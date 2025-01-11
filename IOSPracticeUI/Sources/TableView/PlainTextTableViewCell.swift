//
//  PlainTextTableViewCell.swift
//  TableView
//
//  Created by Simran Rout on 11/04/23.
//

import UIKit

// MARK: PlainTextTableViewCell
public final class PlainTextTableViewCell: UITableViewCell, ReusableView {
    
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
extension PlainTextTableViewCell {
    public func configure(text: String) {
        title.text = text
    }
}

// MARK: Private methods
extension PlainTextTableViewCell {
    private func setupViews() {
        let containerConstraints: Constraints = setupContainerView()
        let titleViewConstraints: Constraints = setupTitleView()
        (containerConstraints + titleViewConstraints).activate()
    }
    
    private func setupContainerView() -> Constraints {
        let constraints: Constraints = contentView.addSubview(containerView) {[
            .height(constant: 150),
            .fill(inset: 20)
        ]}
        containerView.cornerRadius(20)
        return constraints
    }
    
    private func setupTitleView() -> Constraints {
        let constraints = contentView.addSubview(title) {[
            .centerX(),
            .centerY()
        ]}
        title.textColor = .black
        return constraints
    }
}

//MARK: - Preview
#Preview(PlainTextTableViewCell.name, traits: PlainTextTableViewCell.traits, body: PlainTextTableViewCell.preview)
extension PlainTextTableViewCell: PreviewBuilderProtocol {
    public static var traits: PreviewTrait<Preview.ViewTraits> { .fixedLayout(width: 300, height: 160) }
    public static var buildPreview: UIView {
        let cell = PlainTextTableViewCell()
        cell.configure(text: "Test")
        return cell
    }
}
