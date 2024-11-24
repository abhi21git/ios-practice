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

//MARK: - Preview
#Preview(ColorCollectionViewCell.name, traits: ColorCollectionViewCell.traits, body: ColorCollectionViewCell.preview)
extension ColorCollectionViewCell: PreviewBuilderProtocol {
    public static var traits: PreviewTrait<Preview.ViewTraits> {  .fixedLayout(width: 200, height: 200) }
    public static var buildPreview: UIView {
        let cell = ColorCollectionViewCell(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        cell.configureCell(with: UIColor.randomColor)
        return cell
    }
}
