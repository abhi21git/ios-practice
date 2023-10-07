//
//  ColorCollectionViewCell.swift
//  IOSPractice
//
//  Created by Simran Rout on 22/07/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import UIKit

//MARK: - ColorCollectionViewCell
public final class ColorCollectionViewCell: UICollectionViewCell, ReusableView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        cornerRadius(16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(with color: UIColor) {
        backgroundColor = color
    }
}
