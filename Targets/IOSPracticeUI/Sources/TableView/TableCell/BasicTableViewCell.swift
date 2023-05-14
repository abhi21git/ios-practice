//
//  BasicTableViewCell.swift
//  IOSPracticeUI
//
//  Created by Simran Rout on 14/05/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import UIKit

class BasicTableViewCell: UITableViewCell, ReusableView {
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
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cellImageView)
        let constraints: [NSLayoutConstraint] = [
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cellImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellImageView.heightAnchor.constraint(equalToConstant: 40),
            cellImageView.widthAnchor.constraint(equalTo: cellImageView.heightAnchor)
        ]
        return constraints
    }
    
    private func setUpLabel() -> [NSLayoutConstraint] {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        let constraints: [NSLayoutConstraint] = [
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 20)
        ]
        return constraints
    }
    
    public func configure(with data: HomeViewEntries) {
        titleLabel.text = data.title
        cellImageView.image = UIImage(systemName: data.imageName)
    }
}

