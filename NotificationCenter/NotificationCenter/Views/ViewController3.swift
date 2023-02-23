//
//  ViewController3.swift
//  NotificationCenter
//
//  Created by Abhishek Maurya on 23/02/23.
//

import UIKit

class ViewController3: UIViewController {

    @IBOutlet weak var observerDataTextField: UITextField!
    @IBOutlet weak var observerOutputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func didNotificationDataRecieve(_ data: Any?) {
        guard let data = data as? String else {  return }
        observerOutputLabel.text?.append(" \(data)")
    }
    
    @IBAction func addObserver1(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            sender.setTitle("Remove observer 1", for: .normal)
            Notifications.manager.addObserver(for: self, identifier: NotificationName.observer1, selector: #selector(didNotificationDataRecieve(_:)))
        } else {
            sender.setTitle("Add observer 1", for: .normal)
            Notifications.manager.removeObserver(for: self, identifier: NotificationName.observer1)
        }
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
        Notifications.manager.post(identifier: NotificationName.observer3, data: observerDataTextField.text)
    }

}
