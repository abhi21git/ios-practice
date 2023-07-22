//
//  ColorCollectionViewCell.swift
//  IOSPractice
//
//  Created by Simran Rout on 22/07/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import UIKit

public final class ColorCollectionViewCell: UICollectionViewCell, ReusableView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        layer.masksToBounds = true
        layer.cornerRadius = 16.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setColor(color: UIColor) {
        self.backgroundColor = color
    }
}
