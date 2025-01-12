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
public enum Constraint: Equatable {
    case leading(constant: CGFloat = 0, from: NSLayoutXAxisAnchor? = nil, priority: UILayoutPriority = .required)
    case top(constant: CGFloat = 0, from: NSLayoutYAxisAnchor? = nil, priority: UILayoutPriority = .required)
    case trailing(constant: CGFloat = 0, from: NSLayoutXAxisAnchor? = nil, priority: UILayoutPriority = .required)
    case bottom(constant: CGFloat = 0, from: NSLayoutYAxisAnchor? = nil, priority: UILayoutPriority = .required)
    case centerX(constant: CGFloat = 0, from: NSLayoutXAxisAnchor? = nil, priority: UILayoutPriority = .required)
    case centerY(constant: CGFloat = 0, from: NSLayoutYAxisAnchor? = nil, priority: UILayoutPriority = .required)
    case height(constant: CGFloat = 0, equalTo: NSLayoutDimension? = nil, priority: UILayoutPriority = .required)
    case width(constant: CGFloat = 0, equalTo: NSLayoutDimension? = nil, priority: UILayoutPriority = .required)
    case aspectRatio(multiplier: CGFloat = 1, priority: UILayoutPriority = .required)
    case fill(inset: CGFloat = 0, priority: UILayoutPriority = .required)
    
//    func constant(_ value: CGFloat) -> Constraint {
//        return switch self {
//        case .leading(_, let anchor, let priority): .leading(constant: value, from: anchor, priority: priority)
//        case .top(_, let anchor, let priority): .top(constant: value, from: anchor, priority: priority)
//        case .trailing(_, let anchor, let priority): .trailing(constant: value, from: anchor, priority: priority)
//        case .bottom(_, let anchor, let priority): .bottom(constant: value, from: anchor, priority: priority)
//        case .centerX(_, let anchor, let priority): .centerX(constant: value, from: anchor, priority: priority)
//        case .centerY(_, let anchor, let priority): .centerY(constant: value, from: anchor, priority: priority)
//        case .width(_, let anchor, let priority): .width(constant: value, equalTo: anchor, priority: priority)
//        case .height(_, let anchor, let priority): .height(constant: value, equalTo: anchor, priority: priority)
//        case .aspectRatio(let multiplier, priority: let priority): .aspectRatio(multiplier: multiplier, priority: priority)
//        }
//    }
//    
//    func anchor(_ anchor: NSLayoutXAxisAnchor) -> Constraint {
//        return switch self {
//        case .leading(let constant, _, let priority): .leading(constant: constant, from: anchor, priority: priority)
//        case .trailing(let constant, _, let priority): .trailing(constant: constant, from: anchor, priority: priority)
//        case .centerX(let constant, _, let priority): .centerX(constant: constant, from: anchor, priority: priority)
//        default: self // Return self for cases where this anchor doesn't apply
//        }
//    }
//    
//    func anchor(_ anchor: NSLayoutYAxisAnchor) -> Constraint {
//        return switch self {
//        case .top(let constant, _, let priority): .top(constant: constant, from: anchor, priority: priority)
//        case .bottom(let constant, _, let priority): .bottom(constant: constant, from: anchor, priority: priority)
//        case .centerY(let constant, _, let priority): .centerY(constant: constant, from: anchor, priority: priority)
//        default: self // Return self for cases where this anchor doesn't apply
//        }
//    }
//    
//    func anchor(_ anchor: NSLayoutDimension) -> Constraint {
//        return switch self {
//        case .width(let constant, _, let priority): .width(constant: constant, equalTo: anchor, priority: priority)
//        case .height(let constant, _, let priority): .height(constant: constant, equalTo: anchor, priority: priority)
//        default: self // Return self for cases where this anchor doesn't apply
//        }
//    }
//    
//    func priority(_ value: UILayoutPriority) -> Constraint {
//        return switch self {
//        case .leading(let constant, let anchor, _): .leading(constant: constant, from: anchor, priority: value)
//        case .top(let constant, let anchor, _): .top(constant: constant, from: anchor, priority: value)
//        case .trailing(let constant, let anchor, _): .trailing(constant: constant, from: anchor, priority: value)
//        case .bottom(let constant, let anchor, _): .bottom(constant: constant, from: anchor, priority: value)
//        case .centerX(let constant, let anchor, _): .centerX(constant: constant, from: anchor, priority: value)
//        case .centerY(let constant, let anchor, _): .centerY(constant: constant, from: anchor, priority: value)
//        case .width(let constant, let anchor, _): .width(constant: constant, equalTo: anchor, priority: value)
//        case .height(let constant, let anchor, _): .height(constant: constant, equalTo: anchor, priority: value)
//        case .aspectRatio(let multiplier, _): .aspectRatio(multiplier: multiplier, priority: value)
//        }
//    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return switch (lhs, rhs) {
        case (.leading, .leading): true
        case (.top, .top): true
        case (.trailing, .trailing): true
        case (.bottom, .bottom): true
        case (.centerX, .centerX): true
        case (.centerY, .centerY): true
        case (.width, .width): true
        case (.height, .height): true
        case (.aspectRatio, .aspectRatio): true
        case (.fill, .fill): true
        default: false
        }
    }
}

// MARK: - AutoLayoutBuilder
@resultBuilder
public struct AutoLayoutBuilder {
    
    public static func buildBlock(_ components: Constraint...) -> [Constraint] {
        components
    }
    
    public static func buildBlock(_ components: [Constraint]...) -> [Constraint] {
        components.flatMap { $0 }
    }
    
    /// Add support for both single and collections of constraints.
    public static func buildExpression(_ expression: Constraint) -> [Constraint] {
        [expression]
    }
    
    public static func buildExpression(_ expression: [Constraint]) -> [Constraint] {
        expression
    }
    
    public static func buildOptional(_ component: [Constraint]?) -> [Constraint] {
        component ?? []
    }
    
    public static func buildEither(first component: [Constraint]) -> [Constraint] {
        component
    }
    
    public static func buildEither(second component: [Constraint]) -> [Constraint] {
        component
    }
    
    public static func buildArray(_ components: [[Constraint]]) -> [Constraint] {
        components.flatMap { $0 }
    }
    
    public static func buildExpression(_ expression: [[Constraint]]) -> [Constraint] {
        expression.flatMap { $0 }
    }
    
    public static func buildLimitedAvailability(_ component: [Constraint]) -> [Constraint] {
        component
    }
    
    public static func buildExpression(_ expression: Void) -> [Constraint] {
        []
    }
    
    public static func buildExpression(_ expression: Constraint?) -> [Constraint] {
        []
    }
}
