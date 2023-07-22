//
//  UIView+Extensions.swift
//  IOSPractice
//
//  Created by Abhishek Maurya on 13/05/23.
//  Copyright © 2023 practice.com All rights reserved.
//

import UIKit

public typealias Constraints = [NSLayoutConstraint]

public extension UIView {
    
    @discardableResult func makeCircularCorner() -> Self {
        self.layer.cornerRadius = min(bounds.halfHeight, bounds.halfWidth)
        self.layer.masksToBounds = true
        return self
    }
    
    @discardableResult func cornerRadius(_ radius: CGFloat, maskToBounds: Bool = true) -> Self {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = maskToBounds
        return self
    }
    
    @discardableResult func borderWidth(_ width: CGFloat) -> Self {
        self.layer.borderWidth = width
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
    
    func removeTransition() {
        layer.removeAnimation(forKey: kCATransition)
    }
    
    func addSubview(_ subView: UIView, considerSafeArea: Bool = false, with constraints: Array<Constraint>) -> Constraints {
        addSubview(subView)
        return subView.addConstraints(in: self, considerSafeArea: considerSafeArea, with: constraints)
    }
    
    func addConstraints(in view: UIView, considerSafeArea: Bool = false, with constraints: Array<Constraint>) -> Constraints {
        translatesAutoresizingMaskIntoConstraints = false
        
        return constraints.map({ constraint in
            switch constraint {
            case .leading(let constant, let anchor, let priority):
                let leading = anchor ?? (considerSafeArea ? view.safeAreaLayoutGuide.leadingAnchor : view.leadingAnchor)
                return leading.constraint(equalTo: leadingAnchor, constant: -constant).atPriority(priority)
                
            case .top(let constant, let anchor, let priority):
                let top = anchor ?? (considerSafeArea ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor)
                return top.constraint(equalTo: topAnchor, constant: -constant).atPriority(priority)
                
            case .trailing(let constant, let anchor, let priority):
                let trailing = anchor ?? (considerSafeArea ? view.safeAreaLayoutGuide.trailingAnchor : view.trailingAnchor)
                return trailing.constraint(equalTo: trailingAnchor, constant: constant).atPriority(priority)
                
            case .bottom(let constant, let anchor, let priority):
                let bottom = anchor ?? (considerSafeArea ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor)
                return bottom.constraint(equalTo: bottomAnchor, constant: constant).atPriority(priority)
                
            case .centerX(let constant, let anchor, let priority):
                let centerX = anchor ?? (considerSafeArea ? view.safeAreaLayoutGuide.centerXAnchor : view.centerXAnchor)
                return centerX.constraint(equalTo: centerXAnchor, constant: constant).atPriority(priority)
                
            case .centerY(let constant, let anchor, let priority):
                let centerY = anchor ?? (considerSafeArea ? view.safeAreaLayoutGuide.centerYAnchor : view.centerYAnchor)
                return centerY.constraint(equalTo: centerYAnchor, constant: constant).atPriority(priority)
                
            case .height(let constant, let equalTo, let priority):
                if let height = equalTo {
                    return heightAnchor.constraint(equalTo: height, constant: constant).atPriority(priority)
                } else {
                    return heightAnchor.constraint(equalToConstant: constant).atPriority(priority)
                }
                
            case .width(let constant, let equalTo, let priority):
                if let width = equalTo {
                    return widthAnchor.constraint(equalTo: width, constant: constant).atPriority(priority)
                } else {
                    return widthAnchor.constraint(equalToConstant: constant).atPriority(priority)
                }
                
            case .aspectRatio(let multiplier, let priority):
                return widthAnchor.constraint(equalTo: heightAnchor, multiplier: multiplier).atPriority(priority)
            }
        })
    }
}

public enum Constraint {
    case leading(constant: CGFloat = 0, from: NSLayoutXAxisAnchor? = nil, priority: UILayoutPriority = .required)
    case top(constant: CGFloat = 0, from: NSLayoutYAxisAnchor? = nil, priority: UILayoutPriority = .required)
    case trailing(constant: CGFloat = 0, from: NSLayoutXAxisAnchor? = nil, priority: UILayoutPriority = .required)
    case bottom(constant: CGFloat = 0, from: NSLayoutYAxisAnchor? = nil, priority: UILayoutPriority = .required)
    case centerX(constant: CGFloat = 0, from: NSLayoutXAxisAnchor? = nil, priority: UILayoutPriority = .required)
    case centerY(constant: CGFloat = 0, from: NSLayoutYAxisAnchor? = nil, priority: UILayoutPriority = .required)
    case height(constant: CGFloat = 0, equalTo: NSLayoutDimension? = nil, priority: UILayoutPriority = .required)
    case width(constant: CGFloat = 0, equalTo: NSLayoutDimension? = nil, priority: UILayoutPriority = .required)
    case aspectRatio(multiplier: CGFloat = 1, priority: UILayoutPriority = .required)
}
