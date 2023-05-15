//
//  CollectionCompositionLayout.swift
//  Collectionview
//
//  Created by Abhishek Maurya on 10/05/23.
//

import UIKit

// MARK: Custom Compositional layout
final class CustomCollectionViewCompositionalLayout: UICollectionViewCompositionalLayout {
    convenience init() {
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                                   heightDimension: .fractionalHeight(0.3)),
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        header.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 5.0, trailing: 10.0)
        
        let short: LayoutItem = .fractionalSize(width: 1.0, height: 0.25)
            .insets(top: 5, leading: 0, bottom: 5, trailing: 0)
        
        let tall: LayoutItem = .fractionalSize(width: 1.0, height: 0.5)
            .insets(top: 5, leading: 0, bottom: 5, trailing: 0)
        
        let leftGroup = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                                           heightDimension: .fractionalHeight(1)),
                                                         subitems:  [short, short, tall])
        leftGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let rightGroup = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                                            heightDimension: .fractionalHeight(1)),
                                                          subitems:  [tall, short, short])
        rightGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let body = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                             heightDimension: .fractionalHeight(1)),
                                                           subitems: [leftGroup, rightGroup])
        body.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
                
        let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: body)
        section.boundarySupplementaryItems = [header]
        
        self.init(section: section)
    }
}

// MARK: LayoutItem
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
