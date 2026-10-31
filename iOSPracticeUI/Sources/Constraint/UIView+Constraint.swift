//
//  UIView+Constraint.swift
//  IOSPracticeUI
//
//  Created by Abhishek Maurya on 31/10/26.
//  Copyright © 2026 practice.com. All rights reserved.
//

import UIKit

public extension UIView {
    func addSubview(_ subView: UIView, considerSafeArea: Bool = false, _ constraints: () -> Constraint) -> Constraints {
        addSubview(subView)
        return subView.addConstraints(in: self, considerSafeArea: considerSafeArea, constraints)
    }
    
    func addConstraints(in view: UIView, considerSafeArea: Bool = false, _ constraints: () -> Constraint) -> Constraints {
        translatesAutoresizingMaskIntoConstraints = false
        return constraints().makers.map { $0(self, view, considerSafeArea) }
    }
}
