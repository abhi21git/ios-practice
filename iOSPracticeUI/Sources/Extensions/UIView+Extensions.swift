//
//  UIView+Extensions.swift
//  IOSPractice
//
//  Created by Abhishek Maurya on 13/05/23.
//  Copyright © 2023 practice.com All rights reserved.
//

import UIKit

public extension UIView {
    @discardableResult func addShadow(radius: CGFloat = 1, colour: UIColor = .black, opacity: Float = 0.5, offset: CGSize = CGSize(width: 1, height: 1)) -> Self {
        layer.shadowColor = colour.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.masksToBounds = false
        return self
    }
    
    @discardableResult func addBorder(width: CGFloat = 1, colour: UIColor = .black) -> Self {
        layer.borderWidth = width
        layer.borderColor = colour.cgColor
        return self
    }
    
    @discardableResult func makeCircularCorner() -> Self {
        layer.cornerRadius = min(bounds.halfHeight, bounds.halfWidth)
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult func cornerRadius(_ radius: CGFloat, maskToBounds: Bool = true) -> Self {
        layer.cornerRadius = radius
        layer.cornerCurve = .continuous
        layer.masksToBounds = maskToBounds
        return self
    }
    
    func transition(for duration: CGFloat = 0.25, after delay: CGFloat = 0, animation animations: () -> Void, completion: ((Bool) -> Void)? = nil) {
        removeTransition()
        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            completion?(self?.layer.animation(forKey: kCATransition) != nil)
        }
        let currentLayerTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        let animation: CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type = .reveal
        animation.beginTime = currentLayerTime + delay
        animation.subtype = .fromRight
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = .backwards
        animations()
        layer.add(animation, forKey: kCATransition)
        CATransaction.commit()
    }
    
    @inlinable func removeTransition() {
        layer.removeAnimation(forKey: kCATransition)
    }
}
