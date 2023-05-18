//
//  CollectionViewCell.swift
//  Collectionview
//
//  Created by Simran Rout on 08/05/23.
//

import UIKit

// MARK: CollectionViewCell
final class CollectionViewCell: UICollectionViewCell, ReusableView {
    
    // MARK: Properties
    private let imageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let indexLabel: UILabel = UILabel()
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: CollectionViewCell Public Methods
extension CollectionViewCell {
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
            self?.indexLabel.transform = .identity
        }
    }
}

// MARK: CollectionViewCell Private Methods
extension CollectionViewCell {
    private func setUpViews() {
        let imageConstraints: Constraints = setupImageView()
        let titleConstraints: Constraints = setupLabelView()
        (imageConstraints + titleConstraints).activate()
    }
    
    private func setupImageView() -> Constraints {
        let constraints: Constraints = contentView.addSubview(imageView,
                                                              with: [.leading(),
                                                                     .trailing(),
                                                                     .top(),
                                                                     .bottom()])
        imageView.cornerRadius(10)
        imageView.contentMode = .scaleAspectFill
        return constraints
    }
    
    private func setupLabelView() -> Constraints {
        let titleConstraints: Constraints = imageView.addSubview(titleLabel, with: [
            .leading(),
            .trailing(),
            .bottom(),
            .height(constant: 20)
        ])
        let indexConstraints: Constraints = imageView.addSubview(indexLabel, with: [
            .top(constant: 5),
            .trailing(constant: 5),
            .aspectRatio(),
            .height(constant: 20)
        ])
        titleLabel.font = .italicSystemFont(ofSize: 15)
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .black.withAlphaComponent(0.6)
        titleLabel.textColor = .white
        
        indexLabel.font = .boldSystemFont(ofSize: 12)
        indexLabel.textAlignment = .center
        indexLabel.backgroundColor = .black.withAlphaComponent(0.6)
        indexLabel.textColor = .white
        indexLabel.cornerRadius(5)
        return titleConstraints + indexConstraints
    }
}
