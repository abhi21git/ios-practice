//
//  ViewController1.swift
//  NotificationCenter
//
//  Created by Abhishek Maurya on 11/02/23.
//

import UIKit

class ViewController1: UIViewController {
    
    @IBOutlet weak var observerDataTextField: UITextField!
    @IBOutlet weak var observerOutputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        removeBadge()
    }

    @objc func didNotificationDataRecieve(_ data: Any?) {
        guard let data = data as? String else { return }
        observerOutputLabel.text?.append(" \(data)")
        incrementBadgeCount()
    }
    
    @IBAction func addObserver2(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            sender.setTitle("Remove observer 2", for: .normal)
            Notifications.manager.addObserver(for: self, identifier: NotificationName.observer2, selector: #selector(didNotificationDataRecieve(_:)))
        } else {
            sender.setTitle("Add observer 2", for: .normal)
            Notifications.manager.removeObserver(for: self, identifier: NotificationName.observer2)
        }
    }
    
    @IBAction func addObserver3(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            sender.setTitle("Remove observer 3", for: .normal)
            Notifications.manager.addObserver(for: self, identifier: NotificationName.observer3, selector: #selector(didNotificationDataRecieve(_:)))
        } else {
            sender.setTitle("Add observer 3", for: .normal)
            Notifications.manager.removeObserver(for: self, identifier: NotificationName.observer3)
        }
    }
    
    @IBAction func addObserver4(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            sender.setTitle("Remove observer 4", for: .normal)
            Notifications.manager.addObserver(for: self, identifier: NotificationName.observer4, selector: #selector(didNotificationDataRecieve(_:)))
        } else {
            sender.setTitle("Add observer 4", for: .normal)
            Notifications.manager.removeObserver(for: self, identifier: NotificationName.observer4)
        }
    }
    
    @IBAction func postAction(_ sender: UIButton) {
        Notifications.manager.post(identifier: NotificationName.observer1, data: observerDataTextField.text)
    }
}
