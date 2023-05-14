//
//  HeaderView.swift
//  Collectionview
//
//  Created by Simran Rout on 10/05/23.
//

import UIKit

final class HeaderView: UICollectionReusableView, ReusableView {
    
    private let imageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    private func setupImageView() {
        let constraints: [NSLayoutConstraint] = addSubview(imageView, with: [.leading(), .trailing(), .top(), .bottom()])
        imageView.image = UIImage(named: "HeaderImage")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10.0
        imageView.layer.masksToBounds = true
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
