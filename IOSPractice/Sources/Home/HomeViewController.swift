//
//  HomeViewController.swift
//  IOSPracticeUI
//
//  Created by Simran Rout on 14/05/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import iOSPracticeKit
import iOSPracticeUI
import SwiftUI
import UIKit

// MARK: HomeViewController
final class HomeViewController: BaseViewController {
    // MARK: Properties
    private let data: [HomeViewEntries] = HomeViewEntries.allCases
    private var tableView: UITableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: Methods
extension HomeViewController {
    private func setupViews() {
        view.backgroundColor = .white
        let tableViewConstraint: Constraints = setUpTableView()
        (tableViewConstraint).activate()
    }
    
    private func setUpTableView() -> Constraints {
        let constraints: Constraints = view.addSubview(tableView, considerSafeArea: true) {[
            .leading(),
            .trailing(),
            .top(),
            .bottom()
        ]}
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.92, alpha: 1)
        tableView.register(BasicTableViewCell.self)
        return constraints
    }
}

//MARK: Table Data Source and Delegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BasicTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: data[indexPath.row].getCellModel())
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = data[indexPath.row].getCurrentController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Preview
#Preview(HomeViewController.name, body: HomeViewController.preview)
extension HomeViewController: PreviewBuilderProtocol {
    static var buildPreview: UIViewController { UINavigationController(rootViewController: HomeViewController(title: "Home")) }
}

private extension HomeViewEntries {
    @MainActor
    func getCurrentController() -> UIViewController {
        switch self {
        case .tableView:
            return CustomTableCellAnimationController(title: title)
        case .collectionView:
            return CollectionCompositionLayoutController(title: title)
        case .colorPicker:
            return ColorPickerViewController(title: title)
        case .notificationCenter:
            return NotificationViewController(title: title)
        case .swiftUIParallax:
            let vc = UIHostingController(rootView: SwiftUIParallaxView(viewModel: LPViewModel()))
            vc.title = title
            return vc
        }
    }
    
    func getCellModel() -> BasicTableViewCellModel {
        return BasicTableViewCellModel(title: title, image: UIImage(systemName: imageName))
    }
}
