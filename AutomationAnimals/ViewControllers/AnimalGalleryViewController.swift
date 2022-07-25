//
//  AnimalGalleryViewController.swift
//  AutomationAnimals
//
//  Created by Matthew Glover on 22/07/2022.
//

import UIKit

enum Section: Int {
    case main
}

class AnimalGalleryViewController: UIViewController {

    var animalDataService: AnimalsDataService?
    var favoritesService: FavoritesService?
    
    private var datasource: UICollectionViewDiffableDataSource<Section, Animal>!
    private var snapshot: NSDiffableDataSourceSnapshot<Section, Animal>!
    
    private var noAnimalsFoundLabel: UILabel!
    private var collectionView: UICollectionView!
    private var favoriteBarButtonItem: UIBarButtonItem!
    private var filterBarButtonItem: UIBarButtonItem!
    
    private var showingFavorites: Bool = false
    private var filteredTags: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(animalDataService != nil)
        assert(favoritesService != nil)
        
        title = "Animal Gallery"
        view.backgroundColor = .systemBackground
        navigationItem.backButtonTitle = ""
        
        setupNoAnimalsFoundLabel()
        setupGalleryCollectionView()
        setupNavigationItems()
        setupNotificationObservers()
        
        updateFilteredAnimals(animated: false)
    }
    
    private func setupNoAnimalsFoundLabel() {
        noAnimalsFoundLabel = UILabel(frame: .zero)
        noAnimalsFoundLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noAnimalsFoundLabel)
        noAnimalsFoundLabel.text = "No Animals Found"
        noAnimalsFoundLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            noAnimalsFoundLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            noAnimalsFoundLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
    
    private func setupGalleryCollectionView() {
     
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        collectionView.register(AnimalGalleryCollectionViewCell.self, forCellWithReuseIdentifier: AnimalGalleryCollectionViewCell.identifier)
        collectionView.delegate = self
        
        datasource = UICollectionViewDiffableDataSource<Section, Animal>(collectionView: collectionView, cellProvider: { collectionView, indexPath, animal in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnimalGalleryCollectionViewCell.identifier, for: indexPath) as? AnimalGalleryCollectionViewCell else {
                fatalError("Unable to dequeue AnimalGalleryCollectionViewCell")
            }
            
            let isFavorited = self.favoritesService?.isFavorite(id: animal.id) ?? false
            cell.configure(withAnimal: animal, isFavorited: isFavorited)
            
            return cell
        })
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 8.0, leading: 8.0, bottom: 8.0, trailing: 8.0)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            
            let section = NSCollectionLayoutSection(group: group)

            return section
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 8

        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        return layout
    }
    
    private func setupNavigationItems() {
        
        favoriteBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(favoritesButtonTapped(_:)))
        favoriteBarButtonItem.tintColor = .systemYellow
        navigationItem.leftBarButtonItem = favoriteBarButtonItem
        
        filterBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonTapped(_:)))
        navigationItem.rightBarButtonItem = filterBarButtonItem
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(favoritesUpdated(_:)), name: .favouritesUpdated, object: nil)
    }
    
    //MARK: - Notification Observers
    @objc private func favoritesUpdated(_ notification: Notification) {
        updateFilteredAnimals(forceReload: true)
    }
    
    //MARK: - Update CollectionView
    private func updateFilteredAnimals(animated: Bool = true, forceReload: Bool = false) {
        let filteredAnimals = filteredAnimals()
        snapshot = NSDiffableDataSourceSnapshot<Section, Animal>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filteredAnimals, toSection: .main)
        
        if forceReload {
            datasource.applySnapshotUsingReloadData(snapshot) {
                self.checkForNoAnimals()
            }
        } else {
            datasource.apply(snapshot, animatingDifferences: animated) {
                self.checkForNoAnimals()
            }
        }
    }
    
    private func checkForNoAnimals() {
        let noAnimals = snapshot.numberOfItems(inSection: .main) == 0
        UIView.animate(withDuration: 0.4, delay: 0.0) {
            self.collectionView.alpha = noAnimals ? 0.0 : 1.0
        }
    }
    
    //MARK: - Filtering
    private func filteredAnimals() -> [Animal] {
        guard let animals = animalDataService?.animals, let favoritesService = favoritesService else {
            return []
        }
        
        var candidateAnimals: [Animal]
        
        if filteredTags.isEmpty == true {
            candidateAnimals = animals
        } else {
            var foundAnimals: Set<Animal> = []
            for filterTag in filteredTags {
                for animal in animals {
                    if animal.tags.contains(filterTag) {
                        foundAnimals.insert(animal)
                    }
                }
            }
            candidateAnimals = Array(foundAnimals)
        }
        
        if showingFavorites == true {
            var indiciesToRemove: [Int] = []
            for (index, candidateAnimal) in candidateAnimals.enumerated() {
                if favoritesService.isFavorite(id: candidateAnimal.id) == false {
                    indiciesToRemove.append(index)
                }
            }
            
            for index in indiciesToRemove.reversed() {
                candidateAnimals.remove(at: index)
            }
        }
        
        return Array(candidateAnimals).sorted(by: {$0.name < $1.name})
    }
    
    //MARK: - Actions
    @objc private func favoritesButtonTapped(_ sender: UIBarButtonItem) {
        showingFavorites.toggle()
        showingFavoritesStateUpdateUI()
    }
    
    @objc private func filterButtonTapped(_ sender: UIBarButtonItem) {
        let filterViewController = FilterViewController()
        filterViewController.delegate = self
        filterViewController.configure(withTags: animalDataService!.allTags, selectedTags: filteredTags)
        let navigationController = UINavigationController(rootViewController: filterViewController)

        if let sheet = navigationController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        
        present(navigationController, animated: true, completion: nil)
    }
    
    private func showingFavoritesStateUpdateUI() {
        let imagename = showingFavorites ? "star.fill" : "star"
        favoriteBarButtonItem.image = UIImage(systemName: imagename)
        updateFilteredAnimals()
    }
}

extension AnimalGalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item <= filteredAnimals().count else {
            return
        }
        
        let cell = collectionView.cellForItem(at: indexPath)
        let animal = filteredAnimals()[indexPath.row]
        let animalDetailsViewController = AnimalDetailViewController()
        animalDetailsViewController.animal = animal
        animalDetailsViewController.favoritesService = favoritesService
        animalDetailsViewController.animalBackgroundColor = cell?.contentView.backgroundColor
        
        navigationController?.pushViewController(animalDetailsViewController, animated: true)
    }
}

extension AnimalGalleryViewController: FilterViewControllerDelegate {
    func viewController(_ : FilterViewController, didChangeSelectedTags filterTags: [String]) {
        self.filteredTags = filterTags
        
        if filterTags.isEmpty {
            filterBarButtonItem.title = "Filter"
        } else {
            filterBarButtonItem.title = "Filter (\(filteredTags.count))"
        }
        
        updateFilteredAnimals()
    }
}

