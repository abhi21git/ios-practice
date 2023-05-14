//
//  BasicTableViewCell.swift
//  IOSPracticeUI
//
//  Created by Simran Rout on 14/05/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import UIKit

final class BasicTableViewCell: UITableViewCell, ReusableView {
    private var titleLabel: UILabel = UILabel(frame: .zero)
    private var cellImageView: UIImageView = UIImageView(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        selectionStyle = .none
        let imageConstraint: [NSLayoutConstraint] = setUpImageView()
        let titleConstraint: [NSLayoutConstraint] = setUpLabel()
        NSLayoutConstraint.activate(imageConstraint + titleConstraint)
    }
    
    private func setUpImageView() -> [NSLayoutConstraint] {
        let constraints: [NSLayoutConstraint] = contentView.addSubview(cellImageView, with: [
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
    
    private func setUpLabel() -> [NSLayoutConstraint] {
        let constraints: [NSLayoutConstraint] = contentView.addSubview(titleLabel, with: [
            .leading(constant: 20, from: cellImageView.trailingAnchor),
            .trailing(constant: 20),
            .centerY()
        ])
        return constraints
    }
    
    public func configure(with data: HomeViewEntries) {
        titleLabel.text = data.title
        cellImageView.image = UIImage(systemName: data.imageName)
    }
}

