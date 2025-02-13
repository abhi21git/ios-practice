//
//  UILabel+Extensions.swift
//  IOSPracticeUI
//
//  Created by Abhishek Maurya on 15/05/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import UIKit

public extension UILabel {
    @discardableResult func lines(_ numberOfLines: Int) -> Self {
        self.numberOfLines = numberOfLines
        return self
    }
    
    @discardableResult func text(_ text: String) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult func alignment(_ alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }
}
