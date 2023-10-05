//
//  MoreViewController.swift
//  IOSPracticeUI
//
//  Created by Simran Rout on 14/05/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import IOSPracticeKit
import IOSPracticeUI
import UIKit

// MARK: MoreViewController
final class MoreViewController: BaseViewController {
    // MARK: Properties
    private let notificationLabel: UILabel = UILabel()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addNotificationObservers()
    }
}

// MARK: Methods
extension MoreViewController {
    
    private func setupViews() {
        view.backgroundColor = .white
        let notificationLabelConstraints: Constraints = setupTitleLabel()
        (notificationLabelConstraints).activate()
    }
    
    private func prepareUI() {
        view.layoutIfNeeded()
    }
    
    private func setupTitleLabel() -> Constraints {
        let constraint: Constraints = view.addSubview(notificationLabel, considerSafeArea: true, with: [
            .leading(constant: 20),
            .top(constant: 20),
            .centerX()
        ])
        notificationLabel.font = .boldSystemFont(ofSize: 18)
        notificationLabel.text = "Notification text:"
        notificationLabel.textColor = .black
        notificationLabel.numberOfLines = 0
        return constraint
    }
    
    private func addNotificationObservers() {
        Notifications.manager.addObserver(for: self, identifier: NotificationName.observer1, selector: #selector(didNotificationDataRecieve(_:)))
    }
    
    @objc private func didNotificationDataRecieve(_ data: Any?) {
        guard let data = data as? String else {  return }
        notificationLabel.text?.append(" \(data)")
    }
}
