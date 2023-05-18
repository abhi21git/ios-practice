//
//  TableViewCell.swift
//  TableView
//
//  Created by Simran Rout on 11/04/23.
//

import UIKit

// MARK: TableViewCell
final class TableViewCell: UITableViewCell, ReusableView {
    
    // MARK: Properties
    public var containerView: GradientView = GradientView()
    private var title: UILabel = UILabel()
    
    // MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: Public methods
extension TableViewCell {
    public func configure(text: String) {
        title.text = text
    }
}

// MARK: Private methods
extension TableViewCell {
    private func setupViews() {
        let containerConstraints: Constraints = setupContainerView()
        let titleViewConstraints: Constraints = setupTitleView()
        (containerConstraints + titleViewConstraints).activate()
    }
    
    private func setupContainerView() -> Constraints {
        let constraints: Constraints = contentView.addSubview(containerView, with: [
            .height(constant: 200),
            .top(constant: 20),
            .bottom(constant: 20),
            .leading(constant: 20),
            .trailing(constant: 20)
        ])
        containerView.cornerRadius(20)
        containerView.backgroundColor = UIColor.systemMint
        return constraints
    }
    
    private func setupTitleView() -> Constraints {
        let constraints = contentView.addSubview(title, with: [.centerX(), .centerY()])
        title.textColor = .black
        return constraints
    }
}
