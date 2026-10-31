//
//  Array+NSLayoutConstraint+Extensions.swift
//  IOSPracticeUI
//
//  Created by Abhishek Maurya on 15/05/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import UIKit

public extension Array where Element == NSLayoutConstraint {
    @inlinable func activate() {
        NSLayoutConstraint.activate(self)
    }
}

