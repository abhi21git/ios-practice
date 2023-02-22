//
//  ViewController.swift
//  NotificationCenter
//
//  Created by Abhishek Maurya on 11/02/23.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationsCenter.default.addObserver(for: self, identifier: "user.login", handler: #selector(didNotificationDataRecieve(_:)))
        let vc2 = ViewController2()
        vc2.viewDidLoad()
        LoginViewController().sendData()
    }

    @objc func didNotificationDataRecieve(_ data: Any?) {
        if let data = data as? [String: Any] {
            print(self, data["user"])
        }
    }
}

class LoginViewController: UIViewController {
    let data = ["user": ["userId": 7, "userName": "John"]]
    func sendData() {
        NotificationsCenter.default.post(identifier: "user.login", data: data)
    }
}

class ViewController2: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationsCenter.default.addObserver(for: self, identifier: "user.login", handler: #selector(didNotificationDataRecieveHmm(_:)))
    }

    @objc func didNotificationDataRecieveHmm(_ data: Any?) {
        if let data = data as? [String: Any] {
            print(self, data["user"])
        }
    }
}
