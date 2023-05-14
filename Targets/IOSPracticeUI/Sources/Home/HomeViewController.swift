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
    private var tableView: UITableView = UITableView(frame: .zero)
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    private func setUpViews() {
        view.backgroundColor = .white
        let tableViewConstraint: [NSLayoutConstraint] = setUpTableView()
        NSLayoutConstraint.activate(tableViewConstraint)
    }
    
    private func setUpTableView() -> [NSLayoutConstraint] {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(BasicTableViewCell.self)
        let constraints: [NSLayoutConstraint] = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
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
            navigationController?.pushViewController(CollectionCompositionLayoutController(), animated: true)
        case .notificationCenter:
            break
        }
    }
}
