//
//  UIScrollView+Extension.swift
//  IOSPracticeUI
//
//  Created by Abhishek Maurya on 13/05/23.
//  Copyright © 2023 practice.com All rights reserved.
//

import UIKit

public extension UIScrollView {
    var offset: (top: CGPoint, bottom: CGPoint, center: CGPoint) {
        let bottom: (x: CGFloat, y: CGFloat) = (x: contentOffset.x + frame.width,
                                                y: contentOffset.y + frame.height)
        
        let center: (x: CGFloat, y: CGFloat) = (x: contentOffset.x + frame.halfWidth,
                                                y: contentOffset.y + frame.halfHeight)
        return (top: contentOffset,
                bottom: CGPoint(x: bottom.x, y: bottom.y) ,
                center: CGPoint(x: center.x, y: center.y))
    }
}
