//
//  NotificationViewController.swift
//  IOSPractice
//
//  Created by Abhishek Maurya on 05/10/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import IOSPracticeKit
import IOSPracticeUI
import UIKit

//MARK: - NotificationViewController
class NotificationViewController: BaseViewController {

    private let titleLabel: UILabel = UILabel()
    private let inputField: UITextField = UITextField()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareUI()
    }
}

//MARK: - Setup views
extension NotificationViewController {
    
    private func setupViews() {
        view.backgroundColor = .white
        let titleLabelConstraints: Constraints = setupTitleLabel()
        let inputFieldConstraints: Constraints = setupInputField()
        (titleLabelConstraints + inputFieldConstraints).activate()
    }
    
    private func prepareUI() {
        view.layoutIfNeeded()
    }
    
    private func setupTitleLabel() -> Constraints {
        let constraint: Constraints = view.addSubview(titleLabel, considerSafeArea: true, with: [
            .leading(constant: 20),
            .top(constant: 20),
            .centerX()
        ])
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        titleLabel.text = "Enter the text you want to post"
        titleLabel.numberOfLines = 0
        return constraint
    }
    
    private func setupInputField() -> Constraints {
        let constraint: Constraints = view.addSubview(inputField, with: [
            .leading(from: titleLabel.leadingAnchor),
            .top(constant: 20, from: titleLabel.bottomAnchor),
            .centerX()
        ])
        inputField.font = .boldSystemFont(ofSize: 18)
        inputField.borderStyle = .roundedRect
        inputField.placeholder = "Your text here"
        inputField.delegate = self
        return constraint
    }
}

//MARK: - UITextFieldDelegate
extension NotificationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Notifications.manager.post(identifier: NotificationName.observer1, data: inputField.text)
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Preview
#Preview(NotificationViewController.name, body: NotificationViewController.preview)
extension NotificationViewController: PreviewBuilderProtocol {
    static var buildPreview: UIViewController { NotificationViewController() }
}
