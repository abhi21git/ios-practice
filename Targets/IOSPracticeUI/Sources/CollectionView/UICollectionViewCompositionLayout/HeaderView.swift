//
//  HeaderView.swift
//  Collectionview
//
//  Created by Simran Rout on 10/05/23.
//

import UIKit

// MARK: HeaderView
final class HeaderView: UICollectionReusableView, ReusableView {
    
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
extension HeaderView {
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
