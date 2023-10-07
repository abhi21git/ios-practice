//
//  BaseViewController.swift
//  IOSPractice
//
//  Created by Abhishek Maurya on 05/10/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import UIKit

// MARK: - BaseViewController
open class BaseViewController: UIViewController {

    // MARK: Lifecycle
    public convenience init(title: String) {
        self.init()
        setupNavTitle(title)
    }
    
    private func setupNavTitle(_ title: String) {
        let titleLabel: GradientTextLabel = GradientTextLabel()
        titleLabel.text = " \(title) "
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Helvetica-BoldOblique", size: 18)
        navigationItem.titleView = titleLabel
    }
}

// MARK: - Preview
#Preview("Base View Controller") {
    UINavigationController(rootViewController: BaseViewController(title: "Base View Controller"))
}
