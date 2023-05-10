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
    
    let indexLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .boldSystemFont(ofSize: 12)
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
        customView.addSubview(indexLabel)
        
        NSLayoutConstraint.activate([
            customView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customView.topAnchor.constraint(equalTo: topAnchor),
            customView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: customView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: customView.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20.0),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            indexLabel.heightAnchor.constraint(equalToConstant: 20.0),
            indexLabel.widthAnchor.constraint(equalToConstant: 20.0),
            indexLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 5),
            indexLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -5)
        ])
        imageView.layer.cornerRadius = 10.0
        imageView.layer.masksToBounds = true
        titleLabel.backgroundColor = .white.withAlphaComponent(0.5)
        titleLabel.layer.cornerRadius = 10
        titleLabel.clipsToBounds = true
        
        indexLabel.backgroundColor = .white.withAlphaComponent(0.5)
        indexLabel.layer.cornerRadius = 10
        indexLabel.clipsToBounds = true

    }
    
    func configureCell(placeName: String, imageName: String, index: Int) {
        titleLabel.text = placeName
        imageView.image = UIImage(named: imageName)
        indexLabel.text = "\(index)"
    }
}
