//
//  ImageCollectionHeaderView.swift
//  Collectionview
//
//  Created by Simran Rout on 10/05/23.
//

import UIKit

// MARK: ImageCollectionHeaderView
public final class ImageCollectionHeaderView: UICollectionReusableView, ReusableView {
    
    // MARK: Properties
    private let imageView: UIImageView = UIImageView()
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Methods
extension ImageCollectionHeaderView {
    private func setupImageView() {
        let constraints: Constraints = addSubview(imageView, with: [
            .leading(),
            .trailing(),
            .top(),
            .bottom()
        ])
        imageView.image = UIImage(named: "HeaderImage")
        imageView.contentMode = .scaleAspectFill
        imageView.cornerRadius(10)
        (constraints).activate()
    }
}

//MARK: - Preview
#Preview(ImageCollectionHeaderView.name, traits: ImageCollectionHeaderView.traits, body: ImageCollectionHeaderView.preview)
extension ImageCollectionHeaderView: PreviewBuilderProtocol {
    public static var traits: PreviewTrait<Preview.ViewTraits> { .fixedLayout(width: 400, height: 190) }
    public static var buildPreview: UIView { ImageCollectionHeaderView() }
}
