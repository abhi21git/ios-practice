//
//  CustomTableCellAnimationController.swift
//  TableView
//
//  Created by Simran Rout on 11/04/23.
//

import UIKit

// MARK: CustomTableCellAnimationController
final class CustomTableCellAnimationController: UIViewController {
    // MARK: Properties
    private let data = Array(1...100).lazy.map({ "Here is \($0)" })
    private var tableView: UITableView = UITableView()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    convenience init(title: String) {
        self.init()
        setupNavTitle(title)
    }
}
// MARK: Private methods
extension CustomTableCellAnimationController {
    private func setupNavTitle(_ title: String) {
        let titleLabel: GradientTextLabel = GradientTextLabel()
        titleLabel.text = " \(title) "
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Helvetica-BoldOblique", size: 18)
        navigationItem.titleView = titleLabel
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        let tableConstraints: Constraints = setupTableView()
        (tableConstraints).activate()
    }
    
    private func setupTableView() -> Constraints {
        let constraints: Constraints = view.addSubview(tableView,
                                                       considerSafeArea: true,
                                                       with: [.leading(),
                                                              .trailing(),
                                                              .top(),
                                                              .bottom()])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self)
        tableView.separatorStyle = .none
        return constraints
    }
    
    private func animateCell(_ cell: TableViewCell) {
        cell.alpha = 0.0
        cell.transition() {
            cell.alpha = 1
        }
    }
}

//MARK: Table DataSource and Delegate
extension CustomTableCellAnimationController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.selectionStyle = .none
        cell.configure(text: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? TableViewCell else { return }
        animateCell(cell)
    }
}

//MARK: Scroll Delegate
extension CustomTableCellAnimationController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for cell in tableView.visibleCells {
            guard let cell = cell as? TableViewCell else { return }
            let cellFrameInTable = cell.convert(cell.containerView.frame, to: self.tableView)
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let self = self else { return }
                if CGRectContainsPoint(cellFrameInTable, self.tableView.offset.center) {
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

