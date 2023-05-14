//
//  TableViewCell.swift
//  TableView
//
//  Created by Simran Rout on 11/04/23.
//

import UIKit

final class TableViewCell: UITableViewCell, ReusableView {

    public var containerView: GradientView = GradientView()
    private var title: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setupViews() {
        NSLayoutConstraint.activate(setupContainerView() + setupTitleView())
    }

    private func setupContainerView() -> [NSLayoutConstraint] {
        let constraints = contentView.addSubview(containerView, with: [
                .height(constant: 200),
                .top(constant: 20),
                .bottom(constant: 20),
                .leading(constant: 20),
                .trailing(constant: 20)
            ])
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        containerView.backgroundColor = UIColor.systemMint
        return constraints
    }

    private func setupTitleView() -> [NSLayoutConstraint] {
        let constraints = contentView.addSubview(title, with: [.centerX(), .centerY()])
        title.textColor = .black
        return constraints
    }

    func configure(text: String) {
        title.text = text
    }
}
