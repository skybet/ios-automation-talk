//
//  AnimalGalleryCollectionViewCell.swift
//  AutomationAnimals
//
//  Created by Matthew Glover on 22/07/2022.
//

import UIKit

class AnimalGalleryCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String = "AnimalGalleryCollectionViewCell"
    
    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    private var favoriteImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Should not see this - not supporting xibs")
    }
    
    private func commonInit() {
        contentView.backgroundColor = .random(withAlpha: 0.2)
        contentView.layer.cornerRadius = 8.0
        
        imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        contentView.addSubview(titleLabel)
        
        favoriteImageView = UIImageView(frame: .zero)
        favoriteImageView.translatesAutoresizingMaskIntoConstraints = false
        favoriteImageView.image = UIImage(systemName: "star.fill")
        favoriteImageView.tintColor = .systemYellow
        contentView.addSubview(favoriteImageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
            
            favoriteImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0),
            favoriteImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
            favoriteImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.14),
            favoriteImageView.heightAnchor.constraint(equalTo: favoriteImageView.widthAnchor)
        ])
    }
    
    func configure(withAnimal animal: Animal, isFavorited: Bool = true) {
        imageView.image = UIImage(named: animal.imageName)
        titleLabel.text = animal.name
        favoriteImageView.isHidden = isFavorited == false
    }
}
