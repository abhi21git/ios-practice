//
//  CollectionViewSnapFlowLayout.swift
//  IOSPracticeUI
//
//  Created by Simran Rout on 24/07/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import Foundation
import UIKit

public class CollectionSnapFlowLayout: UICollectionViewFlowLayout {
    
    var onlyScrollToNext: Bool = false
    
    override public func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = self.collectionView else {
            let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset,
                                                         withScrollingVelocity: velocity)
            return latestOffset
        } /// Add some snapping behaviour so that the cell is always centered
        var proposedX: CGFloat = proposedContentOffset.x
        if velocity.x >= 0, onlyScrollToNext {
            proposedX = min(proposedContentOffset.x, collectionView.contentOffset.x + (itemSize.width) / 2)
        } else if velocity.x < 0, onlyScrollToNext {
            proposedX = max(proposedContentOffset.x, collectionView.contentOffset.x - (itemSize.width) / 2)
        }
        
        let targetRect = CGRect(x: proposedX, y: proposedContentOffset.y, width: collectionView.frame.width, height: collectionView.frame.height)
        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }
        let horizontalCenter = proposedX + collectionView.frame.width / 2
        var offsetAdjustment: CGFloat = .greatestFiniteMagnitude
        
        for layoutAttributes in rectAttributes {
            let itemHorizontalCenter = layoutAttributes.center.x
            if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }
        return CGPoint(x: proposedX + offsetAdjustment, y: proposedContentOffset.y)
    }
}
