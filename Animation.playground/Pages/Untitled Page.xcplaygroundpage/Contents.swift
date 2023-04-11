import PlaygroundSupport
import SwiftUI
import UIKit
import Foundation

class TestViewController: UIViewController {
    override func viewDidLoad() {
        let label = UILabel(frame: CGRect(x: 137.5, y: 320, width: 100, height: 40))
        label.text = "Hello World"
        view.addSubview(label)
    }
}



let root = TestViewController()
root.view.frame = CGRect(x: 50, y: 0, width: 375, height: 680)

PlaygroundPage.current.liveView = root
PlaygroundPage.current.needsIndefiniteExecution = true
