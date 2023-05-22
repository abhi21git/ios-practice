//
//  BasicTableViewCell.swift
//  IOSPracticeUI
//
//  Created by Simran Rout on 14/05/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import UIKit

// MARK: BasicTableViewCellModel
public struct BasicTableViewCellModel {
    let title: String, image: UIImage?
    
    public init(title: String, image: UIImage?) {
        self.title = title
        self.image = image
    }
}

// MARK: BasicTableViewCell
public final class BasicTableViewCell: UITableViewCell, ReusableView {
    // MARK: Private properties
    private var titleLabel: UILabel = UILabel(frame: .zero)
    private var cellImageView: UIImageView = UIImageView(frame: .zero)
    
    // MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public methods
extension BasicTableViewCell {
    public func configure(with model: BasicTableViewCellModel) {
        titleLabel.text = model.title
        cellImageView.image = model.image
    }
}

// MARK: Private methods
extension BasicTableViewCell {
    private func setUpViews() {
        selectionStyle = .none
        let imageConstraint: Constraints = setUpImageView()
        let titleConstraint: Constraints = setUpLabel()
        NSLayoutConstraint.activate(imageConstraint + titleConstraint)
    }
    
    private func setUpImageView() -> Constraints {
        let constraints: Constraints = contentView.addSubview(cellImageView, with: [
            .leading(constant: 20),
            .top(constant: 20),
            .bottom(constant: 20),
            .aspectRatio(multiplier: 1),
            .height(constant: 24)
        ])
        cellImageView.tintColor = .orange
        cellImageView.setContentHuggingPriority(.required, for: .horizontal)
        cellImageView.contentMode = .scaleAspectFit
        return constraints
    }
    
    private func setUpLabel() -> Constraints {
        let constraints: Constraints = contentView.addSubview(titleLabel, with: [
            .leading(constant: 20, from: cellImageView.trailingAnchor),
            .trailing(constant: 20),
            .centerY()
        ])
        return constraints
    }
}

