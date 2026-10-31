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

// MARK: - LayoutAnchors
protocol LayoutAnchors {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension UIView: LayoutAnchors {}
extension UILayoutGuide: LayoutAnchors {}

private func pin<T>(_ first: NSLayoutAnchor<T>, _ relation: NSLayoutConstraint.Relation, _ second: NSLayoutAnchor<T>, _ constant: CGFloat) -> NSLayoutConstraint {
    switch relation {
    case .lessThanOrEqual: first.constraint(lessThanOrEqualTo: second, constant: constant)
    case .greaterThanOrEqual: first.constraint(greaterThanOrEqualTo: second, constant: constant)
    default: first.constraint(equalTo: second, constant: constant)
    }
}

private func size(_ dimension: NSLayoutDimension, _ relation: NSLayoutConstraint.Relation, _ other: NSLayoutDimension?, _ multiplier: CGFloat, _ constant: CGFloat) -> NSLayoutConstraint {
    guard let other else {
        return switch relation {
        case .lessThanOrEqual: dimension.constraint(lessThanOrEqualToConstant: constant)
        case .greaterThanOrEqual: dimension.constraint(greaterThanOrEqualToConstant: constant)
        default: dimension.constraint(equalToConstant: constant)
        }
    }
    return switch relation {
    case .lessThanOrEqual: dimension.constraint(lessThanOrEqualTo: other, multiplier: multiplier, constant: constant)
    case .greaterThanOrEqual: dimension.constraint(greaterThanOrEqualTo: other, multiplier: multiplier, constant: constant)
    default: dimension.constraint(equalTo: other, multiplier: multiplier, constant: constant)
    }
}

// MARK: - Constraint
/// Swift joins a line that starts with `.` to the previous line, so a closure body like
/// `.leading(20)` / `.centerX` (one per line) is a single chained expression on `Constraint`.
/// `relation` applies to the spacing: `.trailing(20, relation: .greaterThanOrEqual)` keeps at least 20pt.
public struct Constraint {
    let makers: [(_ view: UIView, _ superview: UIView, _ considerSafeArea: Bool) -> NSLayoutConstraint]

    private static var empty: Self { Self(makers: []) }

    private func adding(safeArea: Bool?, priority: UILayoutPriority, _ make: @escaping (_ view: UIView, _ parent: LayoutAnchors) -> NSLayoutConstraint) -> Self {
        Self(makers: makers + [{ view, superview, considerSafeArea in
            let parent: LayoutAnchors = (safeArea ?? considerSafeArea) ? superview.safeAreaLayoutGuide : superview
            return make(view, parent).atPriority(priority)
        }])
    }

    public static var leading: Self { empty.leading() }
    public static var top: Self { empty.top() }
    public static var trailing: Self { empty.trailing() }
    public static var bottom: Self { empty.bottom() }
    public static var centerX: Self { empty.centerX() }
    public static var centerY: Self { empty.centerY() }
    public static var aspectRatio: Self { empty.aspectRatio() }
    public static var fill: Self { empty.fill() }

    public var leading: Self { leading() }
    public var top: Self { top() }
    public var trailing: Self { trailing() }
    public var bottom: Self { bottom() }
    public var centerX: Self { centerX() }
    public var centerY: Self { centerY() }
    public var aspectRatio: Self { aspectRatio() }
    public var fill: Self { fill() }

    public static func leading(_ constant: CGFloat = 0, from anchor: NSLayoutXAxisAnchor? = nil, relation: NSLayoutConstraint.Relation = .equal, safeArea: Bool? = nil, priority: UILayoutPriority = .required) -> Self { empty.leading(constant, from: anchor, relation: relation, safeArea: safeArea, priority: priority) }
    public static func top(_ constant: CGFloat = 0, from anchor: NSLayoutYAxisAnchor? = nil, relation: NSLayoutConstraint.Relation = .equal, safeArea: Bool? = nil, priority: UILayoutPriority = .required) -> Self { empty.top(constant, from: anchor, relation: relation, safeArea: safeArea, priority: priority) }
    public static func trailing(_ constant: CGFloat = 0, from anchor: NSLayoutXAxisAnchor? = nil, relation: NSLayoutConstraint.Relation = .equal, safeArea: Bool? = nil, priority: UILayoutPriority = .required) -> Self { empty.trailing(constant, from: anchor, relation: relation, safeArea: safeArea, priority: priority) }
    public static func bottom(_ constant: CGFloat = 0, from anchor: NSLayoutYAxisAnchor? = nil, relation: NSLayoutConstraint.Relation = .equal, safeArea: Bool? = nil, priority: UILayoutPriority = .required) -> Self { empty.bottom(constant, from: anchor, relation: relation, safeArea: safeArea, priority: priority) }
    public static func centerX(_ constant: CGFloat = 0, from anchor: NSLayoutXAxisAnchor? = nil, relation: NSLayoutConstraint.Relation = .equal, safeArea: Bool? = nil, priority: UILayoutPriority = .required) -> Self { empty.centerX(constant, from: anchor, relation: relation, safeArea: safeArea, priority: priority) }
    public static func centerY(_ constant: CGFloat = 0, from anchor: NSLayoutYAxisAnchor? = nil, relation: NSLayoutConstraint.Relation = .equal, safeArea: Bool? = nil, priority: UILayoutPriority = .required) -> Self { empty.centerY(constant, from: anchor, relation: relation, safeArea: safeArea, priority: priority) }
    public static func height(_ constant: CGFloat = 0, to dimension: NSLayoutDimension? = nil, multiplier: CGFloat = 1, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> Self { empty.height(constant, to: dimension, multiplier: multiplier, relation: relation, priority: priority) }
    public static func width(_ constant: CGFloat = 0, to dimension: NSLayoutDimension? = nil, multiplier: CGFloat = 1, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> Self { empty.width(constant, to: dimension, multiplier: multiplier, relation: relation, priority: priority) }
    public static func aspectRatio(_ multiplier: CGFloat = 1, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> Self { empty.aspectRatio(multiplier, relation: relation, priority: priority) }
    public static func fill(_ inset: CGFloat = 0, safeArea: Bool? = nil, priority: UILayoutPriority = .required) -> Self { empty.fill(inset, safeArea: safeArea, priority: priority) }

    public func leading(_ constant: CGFloat = 0, from anchor: NSLayoutXAxisAnchor? = nil, relation: NSLayoutConstraint.Relation = .equal, safeArea: Bool? = nil, priority: UILayoutPriority = .required) -> Self {
        adding(safeArea: safeArea, priority: priority) { view, parent in pin(view.leadingAnchor, relation, anchor ?? parent.leadingAnchor, constant) }
    }
    public func top(_ constant: CGFloat = 0, from anchor: NSLayoutYAxisAnchor? = nil, relation: NSLayoutConstraint.Relation = .equal, safeArea: Bool? = nil, priority: UILayoutPriority = .required) -> Self {
        adding(safeArea: safeArea, priority: priority) { view, parent in pin(view.topAnchor, relation, anchor ?? parent.topAnchor, constant) }
    }
    public func trailing(_ constant: CGFloat = 0, from anchor: NSLayoutXAxisAnchor? = nil, relation: NSLayoutConstraint.Relation = .equal, safeArea: Bool? = nil, priority: UILayoutPriority = .required) -> Self {
        adding(safeArea: safeArea, priority: priority) { view, parent in pin(anchor ?? parent.trailingAnchor, relation, view.trailingAnchor, constant) }
    }
    public func bottom(_ constant: CGFloat = 0, from anchor: NSLayoutYAxisAnchor? = nil, relation: NSLayoutConstraint.Relation = .equal, safeArea: Bool? = nil, priority: UILayoutPriority = .required) -> Self {
        adding(safeArea: safeArea, priority: priority) { view, parent in pin(anchor ?? parent.bottomAnchor, relation, view.bottomAnchor, constant) }
    }
    public func centerX(_ constant: CGFloat = 0, from anchor: NSLayoutXAxisAnchor? = nil, relation: NSLayoutConstraint.Relation = .equal, safeArea: Bool? = nil, priority: UILayoutPriority = .required) -> Self {
        adding(safeArea: safeArea, priority: priority) { view, parent in pin(view.centerXAnchor, relation, anchor ?? parent.centerXAnchor, constant) }
    }
    public func centerY(_ constant: CGFloat = 0, from anchor: NSLayoutYAxisAnchor? = nil, relation: NSLayoutConstraint.Relation = .equal, safeArea: Bool? = nil, priority: UILayoutPriority = .required) -> Self {
        adding(safeArea: safeArea, priority: priority) { view, parent in pin(view.centerYAnchor, relation, anchor ?? parent.centerYAnchor, constant) }
    }
    public func height(_ constant: CGFloat = 0, to dimension: NSLayoutDimension? = nil, multiplier: CGFloat = 1, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> Self {
        adding(safeArea: nil, priority: priority) { view, _ in size(view.heightAnchor, relation, dimension, multiplier, constant) }
    }
    public func width(_ constant: CGFloat = 0, to dimension: NSLayoutDimension? = nil, multiplier: CGFloat = 1, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> Self {
        adding(safeArea: nil, priority: priority) { view, _ in size(view.widthAnchor, relation, dimension, multiplier, constant) }
    }
    public func aspectRatio(_ multiplier: CGFloat = 1, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> Self {
        adding(safeArea: nil, priority: priority) { view, _ in size(view.widthAnchor, relation, view.heightAnchor, multiplier, 0) }
    }
    public func fill(_ inset: CGFloat = 0, safeArea: Bool? = nil, priority: UILayoutPriority = .required) -> Self {
        leading(inset, safeArea: safeArea, priority: priority)
            .top(inset, safeArea: safeArea, priority: priority)
            .trailing(inset, safeArea: safeArea, priority: priority)
            .bottom(inset, safeArea: safeArea, priority: priority)
    }
}
