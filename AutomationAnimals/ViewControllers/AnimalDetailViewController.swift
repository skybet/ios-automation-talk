//
//  AnimalDetailViewController.swift
//  AutomationAnimals
//
//  Created by Matthew Glover on 22/07/2022.
//

import UIKit

class AnimalDetailViewController: UIViewController {

    var animal: Animal?
    var animalBackgroundColor: UIColor?
    var favoritesService: FavoritesService?
    
    private var favoriteImageView: UIImageView!
    private var animalImageView: UIImageView!
    private var animalNameLabel: UILabel!
    private var tagsListLabel: UILabel!
    private var favoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        assert(animal != nil)
        assert(favoritesService != nil)
        
        view.backgroundColor = .systemBackground
    
        setupSubviews()
        setupConstraints()
        
        title = animal!.name
        animalImageView.image = UIImage(named: animal!.imageName)
        animalNameLabel.text = animal!.name
        tagsListLabel.text = animal?.tags.joined(separator: ", ")
        
       updateFavoriteStatus()
    }
    
    private func setupSubviews() {
                
        animalImageView = UIImageView(frame: .zero)
        animalImageView.translatesAutoresizingMaskIntoConstraints = false
        animalImageView.backgroundColor = animalBackgroundColor
        animalImageView.layer.cornerRadius = 16.0
        view.addSubview(animalImageView)
        
        favoriteImageView = UIImageView(frame: .zero)
        favoriteImageView.translatesAutoresizingMaskIntoConstraints = false
        favoriteImageView.image = UIImage(systemName: "star.fill")
        favoriteImageView.tintColor = .systemYellow
        animalImageView.addSubview(favoriteImageView)
        
        animalNameLabel = UILabel(frame: .zero)
        animalNameLabel.translatesAutoresizingMaskIntoConstraints = false
        animalNameLabel.font = .preferredFont(forTextStyle: .title1)
        animalNameLabel.textAlignment = .center
        view.addSubview(animalNameLabel)
        
        tagsListLabel = UILabel(frame: .zero)
        tagsListLabel.translatesAutoresizingMaskIntoConstraints = false
        tagsListLabel.font = .preferredFont(forTextStyle: .caption1)
        tagsListLabel.textAlignment = .center
        tagsListLabel.numberOfLines = 0
        view.addSubview(tagsListLabel)

        favoriteButton = UIButton(frame: .zero)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.layer.cornerRadius = 8.0
        favoriteButton.addTarget(self, action: #selector(toggleFavorite(_:)), for: .touchUpInside)
        view.addSubview(favoriteButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            animalImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32.0),
            animalImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animalImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 280.0),
            animalImageView.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            animalImageView.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            animalImageView.heightAnchor.constraint(equalTo: animalImageView.widthAnchor),
            
            favoriteImageView.topAnchor.constraint(equalTo: animalImageView.topAnchor, constant: 16.0),
            favoriteImageView.trailingAnchor.constraint(equalTo: animalImageView.trailingAnchor, constant: -16.0),
            favoriteImageView.widthAnchor.constraint(equalTo: animalImageView.widthAnchor, multiplier: 0.1),
            favoriteImageView.heightAnchor.constraint(equalTo: favoriteImageView.widthAnchor),
            
            animalNameLabel.topAnchor.constraint(equalTo: animalImageView.bottomAnchor, constant: 16.0),
            animalNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            animalNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            
            tagsListLabel.topAnchor.constraint(equalTo: animalNameLabel.bottomAnchor, constant: 8.0),
            tagsListLabel.leadingAnchor.constraint(equalTo: animalNameLabel.leadingAnchor),
            tagsListLabel.trailingAnchor.constraint(equalTo: animalNameLabel.trailingAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: tagsListLabel.bottomAnchor, constant: 32.0),
            favoriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favoriteButton.widthAnchor.constraint(equalTo: animalImageView.widthAnchor, multiplier: 0.8),
            favoriteButton.heightAnchor.constraint(equalToConstant: 48.0),
        ])
    }
    
    @objc private func toggleFavorite(_ sender: UIButton) {
        guard let favoritesService = favoritesService, let animalId = animal?.id else {
            return
        }
        
        if favoritesService.isFavorite(id: animalId) {
            favoritesService.removeFavorite(id: animalId)
        } else {
            favoritesService.addFavorite(id: animalId)
        }
        
        updateFavoriteStatus()
    }
    
    private func updateFavoriteStatus() {
        let isFavorite = favoritesService!.isFavorite(id: animal!.id)
        favoriteImageView.isHidden = isFavorite == false
        let favoriteButtonTitle = isFavorite ? "Remove Favourite" : "Favourite"
        favoriteButton.setTitle(favoriteButtonTitle, for: .normal)
        favoriteButton.backgroundColor = isFavorite ? .systemOrange : .systemGreen
    }
}
