//
//  NSLayoutConstraint+Extensions.swift
//  IOSPracticeUI
//
//  Created by Abhishek Maurya on 14/05/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import UIKit

public typealias Constraints = [NSLayoutConstraint]

public extension NSLayoutConstraint {
    func atPriority(_ priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
}

// MARK: - Constraint
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

// MARK: - Chaining
/// Swift joins a line that starts with `.` to the previous line, so a closure body like
/// `.leading(20)` / `.centerX` (one per line) is a single chained expression on `[Constraint]`.
public extension Array where Element == Constraint {
    static var leading: Self { Self().leading() }
    static var top: Self { Self().top() }
    static var trailing: Self { Self().trailing() }
    static var bottom: Self { Self().bottom() }
    static var centerX: Self { Self().centerX() }
    static var centerY: Self { Self().centerY() }
    static var aspectRatio: Self { Self().aspectRatio() }
    static var fill: Self { Self().fill() }

    var leading: Self { leading() }
    var top: Self { top() }
    var trailing: Self { trailing() }
    var bottom: Self { bottom() }
    var centerX: Self { centerX() }
    var centerY: Self { centerY() }
    var aspectRatio: Self { aspectRatio() }
    var fill: Self { fill() }

    static func leading(_ constant: CGFloat = 0, from anchor: NSLayoutXAxisAnchor? = nil, priority: UILayoutPriority = .required) -> Self { Self().leading(constant, from: anchor, priority: priority) }
    static func top(_ constant: CGFloat = 0, from anchor: NSLayoutYAxisAnchor? = nil, priority: UILayoutPriority = .required) -> Self { Self().top(constant, from: anchor, priority: priority) }
    static func trailing(_ constant: CGFloat = 0, from anchor: NSLayoutXAxisAnchor? = nil, priority: UILayoutPriority = .required) -> Self { Self().trailing(constant, from: anchor, priority: priority) }
    static func bottom(_ constant: CGFloat = 0, from anchor: NSLayoutYAxisAnchor? = nil, priority: UILayoutPriority = .required) -> Self { Self().bottom(constant, from: anchor, priority: priority) }
    static func centerX(_ constant: CGFloat = 0, from anchor: NSLayoutXAxisAnchor? = nil, priority: UILayoutPriority = .required) -> Self { Self().centerX(constant, from: anchor, priority: priority) }
    static func centerY(_ constant: CGFloat = 0, from anchor: NSLayoutYAxisAnchor? = nil, priority: UILayoutPriority = .required) -> Self { Self().centerY(constant, from: anchor, priority: priority) }
    static func height(_ constant: CGFloat = 0, equalTo dimension: NSLayoutDimension? = nil, priority: UILayoutPriority = .required) -> Self { Self().height(constant, equalTo: dimension, priority: priority) }
    static func width(_ constant: CGFloat = 0, equalTo dimension: NSLayoutDimension? = nil, priority: UILayoutPriority = .required) -> Self { Self().width(constant, equalTo: dimension, priority: priority) }
    static func aspectRatio(_ multiplier: CGFloat = 1, priority: UILayoutPriority = .required) -> Self { Self().aspectRatio(multiplier, priority: priority) }
    static func fill(_ inset: CGFloat = 0, priority: UILayoutPriority = .required) -> Self { Self().fill(inset, priority: priority) }

    func leading(_ constant: CGFloat = 0, from anchor: NSLayoutXAxisAnchor? = nil, priority: UILayoutPriority = .required) -> Self { self + [.leading(constant: constant, from: anchor, priority: priority)] }
    func top(_ constant: CGFloat = 0, from anchor: NSLayoutYAxisAnchor? = nil, priority: UILayoutPriority = .required) -> Self { self + [.top(constant: constant, from: anchor, priority: priority)] }
    func trailing(_ constant: CGFloat = 0, from anchor: NSLayoutXAxisAnchor? = nil, priority: UILayoutPriority = .required) -> Self { self + [.trailing(constant: constant, from: anchor, priority: priority)] }
    func bottom(_ constant: CGFloat = 0, from anchor: NSLayoutYAxisAnchor? = nil, priority: UILayoutPriority = .required) -> Self { self + [.bottom(constant: constant, from: anchor, priority: priority)] }
    func centerX(_ constant: CGFloat = 0, from anchor: NSLayoutXAxisAnchor? = nil, priority: UILayoutPriority = .required) -> Self { self + [.centerX(constant: constant, from: anchor, priority: priority)] }
    func centerY(_ constant: CGFloat = 0, from anchor: NSLayoutYAxisAnchor? = nil, priority: UILayoutPriority = .required) -> Self { self + [.centerY(constant: constant, from: anchor, priority: priority)] }
    func height(_ constant: CGFloat = 0, equalTo dimension: NSLayoutDimension? = nil, priority: UILayoutPriority = .required) -> Self { self + [.height(constant: constant, equalTo: dimension, priority: priority)] }
    func width(_ constant: CGFloat = 0, equalTo dimension: NSLayoutDimension? = nil, priority: UILayoutPriority = .required) -> Self { self + [.width(constant: constant, equalTo: dimension, priority: priority)] }
    func aspectRatio(_ multiplier: CGFloat = 1, priority: UILayoutPriority = .required) -> Self { self + [.aspectRatio(multiplier: multiplier, priority: priority)] }
    func fill(_ inset: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        leading(inset, priority: priority).top(inset, priority: priority).trailing(inset, priority: priority).bottom(inset, priority: priority)
    }
}
