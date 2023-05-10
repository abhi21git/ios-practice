//
//  CollectionViewCell.swift
//  Collectionview
//
//  Created by Simran Rout on 08/05/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let customView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .italicSystemFont(ofSize: 15)
        titleLabel.textAlignment = .center
        return titleLabel
    }()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
    }
    
    private func setUpViews() {
        addSubview(customView)
        customView.addSubview(imageView)
        customView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            customView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4.0),
            customView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4.0),
            customView.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
            customView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: customView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -5.0),
            imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            
            titleLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: customView.bottomAnchor),
        ])
        
        imageView.layer.cornerRadius = 10.0
        imageView.layer.masksToBounds = true
    }
    
    func configureCell(placeName: String, imageName: String) {
        titleLabel.text = placeName
        imageView.image = UIImage(named: imageName)
    }
}
