//
//  ViewController.swift
//  TableView
//
//  Created by Simran Rout on 11/04/23.
//

import UIKit

class ViewController: UIViewController {
    let data = Array(1...100).lazy.map({"Here is \($0)"})
    private var tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "customCell")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        self.navigationController?.isNavigationBarHidden = true
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - DataSource and Delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configure(text: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return -1
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for cell in tableView.visibleCells {
            guard let cell = cell as? TableViewCell else { return }
            UIView.animate(withDuration: 0.3) {
                if CGRectContainsPoint(cell.convert(cell.containerView.frame, to: self.tableView), self.tableView.offset.center) {
                    cell.containerView.transform = .identity
                } else {
                    cell.containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                }
            }
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let cellHeight = tableView.visibleCells.first?.frame.height else { return }
        let expectedCenterY = (targetContentOffset.pointee.y + tableView.frame.height / 2)
        let cellDecimalVal = expectedCenterY / cellHeight
        let point = cellDecimalVal.truncatingRemainder(dividingBy: 1) - 0.50
        targetContentOffset.pointee.y -= cellHeight * point
    }
}

//MARK: - Animation
extension ViewController {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? TableViewCell else { return }
        animateCell(cell)
    }
    
    func animateCell(_ cell: TableViewCell) {
        cell.alpha = 0.0
        cell.animate()  {
            cell.alpha = 1
        }
    }
}


extension UIView {
    func animate(for duration: CGFloat = 0.25, after delay: CGFloat = 0, animation abhi: () -> Void, completion: ((Bool) -> Void)? = nil) {
        etamina()
        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            completion?(self?.layer.animation(forKey: kCATransition) != nil)
        }
        let currentLayerTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        let animation: CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type = .reveal
        animation.beginTime = currentLayerTime + delay
        animation.subtype = .fromRight
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = .backwards
        abhi()
        layer.add(animation, forKey: kCATransition)
        CATransaction.commit()
    }
    
    func etamina() {
        layer.removeAnimation(forKey: kCATransition)
    }
}


// MARK: - Calculate cell is center or not
extension UIScrollView {
    var offset: (top: CGPoint, bottom: CGPoint, center: CGPoint) {
        let bottomX = contentOffset.x + frame.width
        let bottomY = contentOffset.y + frame.height
        
        let cenX = contentOffset.x + (frame.width / 2)
        let cenY = contentOffset.y + (frame.height / 2)
        return (top: contentOffset, bottom: CGPoint(x: bottomX, y: bottomY) , center: CGPoint(x: cenX, y: cenY))
    }
}
