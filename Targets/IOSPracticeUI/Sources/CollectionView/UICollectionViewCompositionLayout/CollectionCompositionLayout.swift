//
//  CollectionCompositionLayout.swift
//  Collectionview
//
//  Created by Abhishek Maurya on 10/05/23.
//

import UIKit

final class LayoutItem: NSCollectionLayoutItem {
    
    static func fractionalSize(width: CGFloat, height: CGFloat) -> LayoutItem {
        return LayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(width), heightDimension: .fractionalHeight(height)))
    }
    
    static func absoluteSize(width: CGFloat, height: CGFloat) -> LayoutItem {
        return LayoutItem(layoutSize: .init(widthDimension: .absolute(width), heightDimension: .absolute(height)))
    }
    
    static func estimatedSize(width: CGFloat, height: CGFloat) -> LayoutItem {
        return LayoutItem(layoutSize: .init(widthDimension: .estimated(width), heightDimension: .estimated(height)))
    }
    
    func insets(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) -> Self {
        contentInsets = NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
        return self
    }
    
    func edgeSpacing(leading: CGFloat, top: CGFloat, trailing: CGFloat, bottom: CGFloat) -> Self {
        edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(leading), top: .fixed(top), trailing: .fixed(trailing), bottom: .fixed(bottom))
        return self
    }
}

final class LayoutGroup: NSCollectionLayoutGroup {
    
}
