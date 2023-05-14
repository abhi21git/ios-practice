//
//  CollectionViewCell.swift
//  Collectionview
//
//  Created by Simran Rout on 08/05/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell, ReusableView {
    
    private let imageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let indexLabel: UILabel = UILabel()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        let imageConstraints: [NSLayoutConstraint] = setupImageView()
        let titleConstraints: [NSLayoutConstraint] = setupLabelView()
        NSLayoutConstraint.activate(imageConstraints + titleConstraints)
    }
    
    private func setupImageView() -> [NSLayoutConstraint] {
        let constraints: [NSLayoutConstraint] = contentView.addSubview(imageView, with: [.leading(), .trailing(), .top(), .bottom()])
        imageView.layer.cornerRadius = 10.0
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return constraints
    }
    
    private func setupLabelView() -> [NSLayoutConstraint] {
        let titleConstraints: [NSLayoutConstraint] = imageView.addSubview(titleLabel, with: [.leading(), .trailing(), .bottom(), .height(constant: 20)])
        let indexConstraints: [NSLayoutConstraint] = imageView.addSubview(indexLabel, with: [.top(constant: 5), .trailing(constant: 5), .aspectRatio(), .height(constant: 20)])
        titleLabel.font = .italicSystemFont(ofSize: 15)
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .black.withAlphaComponent(0.6)
        titleLabel.textColor = .white

        indexLabel.font = .boldSystemFont(ofSize: 12)
        indexLabel.textAlignment = .center
        indexLabel.backgroundColor = .black.withAlphaComponent(0.6)
        indexLabel.textColor = .white
        indexLabel.layer.cornerRadius = 5
        indexLabel.layer.masksToBounds = true
        return titleConstraints + indexConstraints
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
