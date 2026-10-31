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

// MARK: - ConstraintKind
enum ConstraintKind {
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
/// `.leading(20)` / `.centerX` (one per line) is a single chained expression on `Constraint`.
public struct Constraint {
    let constraints: [ConstraintKind]

    public static var leading: Self { Self(constraints: []).leading() }
    public static var top: Self { Self(constraints: []).top() }
    public static var trailing: Self { Self(constraints: []).trailing() }
    public static var bottom: Self { Self(constraints: []).bottom() }
    public static var centerX: Self { Self(constraints: []).centerX() }
    public static var centerY: Self { Self(constraints: []).centerY() }
    public static var aspectRatio: Self { Self(constraints: []).aspectRatio() }
    public static var fill: Self { Self(constraints: []).fill() }

    public var leading: Self { leading() }
    public var top: Self { top() }
    public var trailing: Self { trailing() }
    public var bottom: Self { bottom() }
    public var centerX: Self { centerX() }
    public var centerY: Self { centerY() }
    public var aspectRatio: Self { aspectRatio() }
    public var fill: Self { fill() }

    public static func leading(_ constant: CGFloat = 0, from anchor: NSLayoutXAxisAnchor? = nil, priority: UILayoutPriority = .required) -> Self { Self(constraints: []).leading(constant, from: anchor, priority: priority) }
    public static func top(_ constant: CGFloat = 0, from anchor: NSLayoutYAxisAnchor? = nil, priority: UILayoutPriority = .required) -> Self { Self(constraints: []).top(constant, from: anchor, priority: priority) }
    public static func trailing(_ constant: CGFloat = 0, from anchor: NSLayoutXAxisAnchor? = nil, priority: UILayoutPriority = .required) -> Self { Self(constraints: []).trailing(constant, from: anchor, priority: priority) }
    public static func bottom(_ constant: CGFloat = 0, from anchor: NSLayoutYAxisAnchor? = nil, priority: UILayoutPriority = .required) -> Self { Self(constraints: []).bottom(constant, from: anchor, priority: priority) }
    public static func centerX(_ constant: CGFloat = 0, from anchor: NSLayoutXAxisAnchor? = nil, priority: UILayoutPriority = .required) -> Self { Self(constraints: []).centerX(constant, from: anchor, priority: priority) }
    public static func centerY(_ constant: CGFloat = 0, from anchor: NSLayoutYAxisAnchor? = nil, priority: UILayoutPriority = .required) -> Self { Self(constraints: []).centerY(constant, from: anchor, priority: priority) }
    public static func height(_ constant: CGFloat = 0, equalTo dimension: NSLayoutDimension? = nil, priority: UILayoutPriority = .required) -> Self { Self(constraints: []).height(constant, equalTo: dimension, priority: priority) }
    public static func width(_ constant: CGFloat = 0, equalTo dimension: NSLayoutDimension? = nil, priority: UILayoutPriority = .required) -> Self { Self(constraints: []).width(constant, equalTo: dimension, priority: priority) }
    public static func aspectRatio(_ multiplier: CGFloat = 1, priority: UILayoutPriority = .required) -> Self { Self(constraints: []).aspectRatio(multiplier, priority: priority) }
    public static func fill(_ inset: CGFloat = 0, priority: UILayoutPriority = .required) -> Self { Self(constraints: []).fill(inset, priority: priority) }

    public func leading(_ constant: CGFloat = 0, from anchor: NSLayoutXAxisAnchor? = nil, priority: UILayoutPriority = .required) -> Self { Self(constraints: constraints + [.leading(constant: constant, from: anchor, priority: priority)]) }
    public func top(_ constant: CGFloat = 0, from anchor: NSLayoutYAxisAnchor? = nil, priority: UILayoutPriority = .required) -> Self { Self(constraints: constraints + [.top(constant: constant, from: anchor, priority: priority)]) }
    public func trailing(_ constant: CGFloat = 0, from anchor: NSLayoutXAxisAnchor? = nil, priority: UILayoutPriority = .required) -> Self { Self(constraints: constraints + [.trailing(constant: constant, from: anchor, priority: priority)]) }
    public func bottom(_ constant: CGFloat = 0, from anchor: NSLayoutYAxisAnchor? = nil, priority: UILayoutPriority = .required) -> Self { Self(constraints: constraints + [.bottom(constant: constant, from: anchor, priority: priority)]) }
    public func centerX(_ constant: CGFloat = 0, from anchor: NSLayoutXAxisAnchor? = nil, priority: UILayoutPriority = .required) -> Self { Self(constraints: constraints + [.centerX(constant: constant, from: anchor, priority: priority)]) }
    public func centerY(_ constant: CGFloat = 0, from anchor: NSLayoutYAxisAnchor? = nil, priority: UILayoutPriority = .required) -> Self { Self(constraints: constraints + [.centerY(constant: constant, from: anchor, priority: priority)]) }
    public func height(_ constant: CGFloat = 0, equalTo dimension: NSLayoutDimension? = nil, priority: UILayoutPriority = .required) -> Self { Self(constraints: constraints + [.height(constant: constant, equalTo: dimension, priority: priority)]) }
    public func width(_ constant: CGFloat = 0, equalTo dimension: NSLayoutDimension? = nil, priority: UILayoutPriority = .required) -> Self { Self(constraints: constraints + [.width(constant: constant, equalTo: dimension, priority: priority)]) }
    public func aspectRatio(_ multiplier: CGFloat = 1, priority: UILayoutPriority = .required) -> Self { Self(constraints: constraints + [.aspectRatio(multiplier: multiplier, priority: priority)]) }
    public func fill(_ inset: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        leading(inset, priority: priority).top(inset, priority: priority).trailing(inset, priority: priority).bottom(inset, priority: priority)
    }
}
