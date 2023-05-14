//
//  UIView+Extensions.swift
//  IOSPractice
//
//  Created by Abhishek Maurya on 13/05/23.
//  Copyright © 2023 practice.com All rights reserved.
//

import UIKit

public extension UIView {
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
    
    func removeTransition() {
        layer.removeAnimation(forKey: kCATransition)
    }
}
