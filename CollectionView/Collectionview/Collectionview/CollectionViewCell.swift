//
//  CollectionViewCell.swift
//  Collectionview
//
//  Created by Simran Rout on 08/05/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .italicSystemFont(ofSize: 15)
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .black.withAlphaComponent(0.6)
        titleLabel.textColor = .white
        return titleLabel
    }()
    
    let indexLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .boldSystemFont(ofSize: 12)
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .black.withAlphaComponent(0.6)
        titleLabel.textColor = .white
        return titleLabel
    }()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        contentView.addSubview(imageView)
        imageView.addSubview(titleLabel)
        imageView.addSubview(indexLabel)
        imageView.layer.cornerRadius = 10.0
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        
        indexLabel.layer.cornerRadius = 5
        indexLabel.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20.0),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            indexLabel.heightAnchor.constraint(equalToConstant: 20.0),
            indexLabel.widthAnchor.constraint(equalToConstant: 20.0),
            indexLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 5),
            indexLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -5)
        ])
    }
    
    func configureCell(city: Cities, index: Int) {
        titleLabel.text = city.name
        imageView.image = UIImage(named: city.name)
        indexLabel.text = "\(index)"
    }
    
    func prepareForAnimation() {
        titleLabel.transform = CGAffineTransform(translationX: 0, y: 20)
        indexLabel.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
    }
    
    func animateItems(with duration: TimeInterval = 0.3) {
        UIView.animate(withDuration: duration, delay: 0.3) { [weak self] in
            self?.titleLabel.transform = .identity
            self?.indexLabel.transform  = .identity
        }
    }
}
