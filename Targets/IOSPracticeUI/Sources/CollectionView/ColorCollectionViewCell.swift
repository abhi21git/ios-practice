//
//  ColorCollectionViewCell.swift
//  IOSPractice
//
//  Created by Simran Rout on 22/07/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import UIKit

#if DEBUG
#Preview("Color Collection View Cell", traits: .fixedLayout(width: 200, height: 200)) {
    let cell = ColorCollectionViewCell()
    cell.configureCell(with: UIColor.randomColor)
    return cell
} #endif

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
