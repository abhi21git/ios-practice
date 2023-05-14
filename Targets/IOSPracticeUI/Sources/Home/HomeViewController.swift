//
//  HomeViewController.swift
//  IOSPracticeUI
//
//  Created by Simran Rout on 14/05/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let data: [HomeViewEntries] = HomeViewEntries.allCases
    private var tableView: UITableView = UITableView(frame: .zero, style: .insetGrouped)
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    private func setUpViews() {
        setupNavTitle("Home")
        view.backgroundColor = .white
        let tableViewConstraint: [NSLayoutConstraint] = setUpTableView()
        NSLayoutConstraint.activate(tableViewConstraint)
    }
    
    private func setupNavTitle(_ title: String) {
        let titleLabel: GradientTextLabel = GradientTextLabel()
        titleLabel.text = " \(title) "
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Helvetica-BoldOblique", size: 18)
        navigationItem.titleView = titleLabel
    }
    
    private func setUpTableView() -> [NSLayoutConstraint] {
        let constraints: [NSLayoutConstraint] = view.addSubview(tableView, considerSafeArea: true, with: [.leading(), .trailing(), .top(), .bottom()])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.92, alpha: 1)
        tableView.register(BasicTableViewCell.self)
        return constraints
    }
}

//MARK: - Data Source and Delegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BasicTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry: HomeViewEntries = data[indexPath.row]
        switch entry {
        case .tableView:
            navigationController?.pushViewController(CustomTableCellAnimationController(title: entry.title), animated: true)
        case .collectionView:
            navigationController?.pushViewController(CollectionCompositionLayoutController(title: entry.title), animated: true)
        case .notificationCenter:
            break
        }
    }
}
