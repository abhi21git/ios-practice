//
//  UIStackView+Extensions.swift
//  IOSPracticeUI
//
//  Created by Abhishek Maurya on 15/05/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import UIKit

public extension UIStackView {
    @discardableResult func axis(_ axis: NSLayoutConstraint.Axis) -> Self {
        self.axis = axis
        return self
    }
    
    @discardableResult func alignment(_ alignment: UIStackView.Alignment) -> Self {
        self.alignment = alignment
        return self
    }
    
    @discardableResult func distribution(_ distribution: UIStackView.Distribution) -> Self {
        self.distribution = distribution
        return self
    }
}
