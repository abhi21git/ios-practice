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
        NotificationsCenter.default.addObserver(for: self, identifier: NotificationName.observer1, handler: #selector(didNotificationDataRecieve(_:)))
    }
    
    @IBAction func addObserver2(_ sender: UIButton) {
        NotificationsCenter.default.addObserver(for: self, identifier: NotificationName.observer2, handler: #selector(didNotificationDataRecieve(_:)))
    }
    
    @IBAction func addObserver4(_ sender: UIButton) {
        NotificationsCenter.default.addObserver(for: self, identifier: NotificationName.observer4, handler: #selector(didNotificationDataRecieve(_:)))
    }
    
    @IBAction func postAction(_ sender: UIButton) {
        NotificationsCenter.default.post(identifier: NotificationName.observer3, data: observerDataTextField.text)
    }

}
