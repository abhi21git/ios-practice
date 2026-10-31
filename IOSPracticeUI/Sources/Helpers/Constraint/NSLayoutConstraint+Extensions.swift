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
