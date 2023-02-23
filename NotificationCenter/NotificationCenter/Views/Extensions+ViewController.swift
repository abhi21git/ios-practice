//
//  Extensions+ViewController.swift
//  NotificationCenter
//
//  Created by Abhishek Maurya on 23/02/23.
//

import UIKit

extension UIViewController {
    
    func incrementBadgeCount() {
        guard let badgeCount = Int(tabBarItem.badgeValue ?? "0") else {
            return
        }
        tabBarItem.badgeValue = "\(badgeCount + 1)"
    }
    
    func removeBadge() {
        tabBarItem.badgeValue = nil
    }
}
