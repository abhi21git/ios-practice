//
//  Array+NSLayoutConstraint+Extensions.swift
//  IOSPracticeUI
//
//  Created by Abhishek Maurya on 15/05/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import UIKit

public extension Array where Element == NSLayoutConstraint {
    @inlinable mutating func addConstraint(_ newConstraint: Element) {
        self.append(newConstraint)
    }
    
    @inlinable mutating func addConstraints(_ newConstraints: [Element]) {
        self.append(contentsOf: newConstraints)
    }
    
    /// If you need to chain constraint
    @discardableResult func addAndReturnConstraint(_ newConstraint: Element) -> Self {
        var currentConstraints = self
        currentConstraints.append(newConstraint)
        return currentConstraints
    }
    
    /// If you need to chain constraints
    @discardableResult func addAndReturnConstraints(_ newConstraints: [Element]) -> Self {
        var currentConstraints = self
        currentConstraints.append(contentsOf: newConstraints)
        return currentConstraints
    }
    
    @inlinable func activate() {
        NSLayoutConstraint.activate(self)
    }
}

