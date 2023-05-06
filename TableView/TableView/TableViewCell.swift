//
//  TableViewCell.swift
//  TableView
//
//  Created by Simran Rout on 11/04/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var title: UILabel = {
        var title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(containerView)
        containerView.addSubview(title)
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 200),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            title.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        containerView.layer.cornerRadius = 20
        containerView.backgroundColor = UIColor.systemMint
        title.textColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(text: String) {
        title.text = text
    }
}
