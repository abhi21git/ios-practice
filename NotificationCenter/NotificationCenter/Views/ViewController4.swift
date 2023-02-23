//
//  ViewController4.swift
//  NotificationCenter
//
//  Created by Abhishek Maurya on 23/02/23.
//

import UIKit

class ViewController4: UIViewController {

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
        Notifications.manager.addObserver(for: self, identifier: NotificationName.observer1, selector: #selector(didNotificationDataRecieve(_:)))
    }
    
    @IBAction func addObserver2(_ sender: UIButton) {
        Notifications.manager.addObserver(for: self, identifier: NotificationName.observer2, selector: #selector(didNotificationDataRecieve(_:)))
    }
    
    @IBAction func addObserver3(_ sender: UIButton) {
        Notifications.manager.addObserver(for: self, identifier: NotificationName.observer3, selector: #selector(didNotificationDataRecieve(_:)))
    }
    
    @IBAction func postAction(_ sender: UIButton) {
        Notifications.manager.post(identifier: NotificationName.observer4, data: observerDataTextField.text)
    }

}
