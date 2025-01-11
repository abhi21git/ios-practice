//
//  CollectionViewCell.swift
//  Collectionview
//
//  Created by Simran Rout on 08/05/23.
//

import UIKit

// MARK: ImageCollectionCellModel
public struct ImageCollectionCellModel {
    let title: String, image: UIImage?
    
    public init(title: String, image: UIImage?) {
        self.title = title
        self.image = image
    }
}

// MARK: ImageCollectionViewCell
public final class ImageCollectionViewCell: UICollectionViewCell, ReusableView {
    
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
public extension ImageCollectionViewCell {
    func configureCell(with model: ImageCollectionCellModel, index: Int = -1) {
        titleLabel.text = model.title
        imageView.image = model.image
        indexLabel.isHidden = index == -1
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
extension ImageCollectionViewCell {
    private func setUpViews() {
        let imageConstraints: Constraints = setupImageView()
        let titleConstraints: Constraints = setupLabelView()
        (imageConstraints + titleConstraints).activate()
    }
    
    private func setupImageView() -> Constraints {
        let constraints: Constraints = contentView.addSubview(imageView) { .fill() }
        imageView.cornerRadius(10)
        imageView.contentMode = .scaleAspectFill
        return constraints
    }
    
    private func setupLabelView() -> Constraints {
        let titleConstraints: Constraints = imageView.addSubview(titleLabel) {[
            .leading(),
            .trailing(),
            .bottom(),
            .height(constant: 20)
        ]}
        let indexConstraints: Constraints = imageView.addSubview(indexLabel) {[
            .top(constant: 5),
            .trailing(constant: 5),
            .aspectRatio(),
            .height(constant: 20)
        ]}
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

//MARK: - Preview
#Preview(ImageCollectionViewCell.name, traits: ImageCollectionViewCell.traits, body: ImageCollectionViewCell.preview)
extension ImageCollectionViewCell: PreviewBuilderProtocol {
    public static var traits: PreviewTrait<Preview.ViewTraits> { .fixedLayout(width: 200, height: 200) }
    public static var buildPreview: UIView {
        let cell = ImageCollectionViewCell()
        cell.configureCell(with: ImageCollectionCellModel(title: "Ankara", image: UIImage(named: "Ankara")), index: 0)
        return cell
    }
}
