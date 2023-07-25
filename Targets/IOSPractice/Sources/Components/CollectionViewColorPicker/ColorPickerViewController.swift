//
//  ColorPickerViewController.swift
//  IOSPractice
//
//  Created by Simran Rout on 22/07/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import UIKit
import IOSPracticeUI

//MARK: - ColorPickerViewController
final class ColorPickerViewController: UIViewController {
  
    private var collectionView: ColorCollectionView = ColorCollectionView(color: (1...20).map({ _ in UIColor.randomColor }))
    private var messageLabel: UILabel = UILabel()
    
    // MARK: Lifecycle
    convenience init(title: String) {
        self.init()
        setupNavTitle(title)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareUI()
    }
}

//MARK: - Setup views
extension ColorPickerViewController: UICollectionViewDelegateFlowLayout {
    
    private func setupNavTitle(_ title: String) {
        let titleLabel: GradientTextLabel = GradientTextLabel()
        titleLabel.text = " \(title) "
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Helvetica-BoldOblique", size: 18)
        navigationItem.titleView = titleLabel
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        let collectionConstraints: Constraints = setupCollectionView()
        let infoLabelConstraints: Constraints = setupMessasgeLabel()
        (collectionConstraints + infoLabelConstraints).activate()
    }
    
    private func prepareUI() {
        view.layoutIfNeeded()
        collectionView.addShadow(radius: 3, colour: .darkGray, opacity: 0.2, offset: .zero)
        collectionView.addBorder(width: 1, colour: .white)
        collectionView.makeCircularCorner()
    }
    
    private func setupCollectionView() -> Constraints {
        collectionView.colorDelegate = self
        let constraint: Constraints = view.addSubview(collectionView, considerSafeArea: true, with: [
            .leading(constant: 20.0),
            .trailing(constant: 20.0),
            .top(constant: 20.0),
            .height(constant: 80.0)
        ])
        return constraint
    }
    
    private func setupMessasgeLabel() -> Constraints {
        let constraint: Constraints = view.addSubview(messageLabel, with: [
            .leading(constant: 20),
            .centerX(),
            .centerY()
        ])
        messageLabel.textAlignment = .center
        messageLabel.font = .boldSystemFont(ofSize: 18)
        messageLabel.text = "No colour is selected"
        messageLabel.numberOfLines = 0
        return constraint
    }
}

extension ColorPickerViewController: ColorCollectionViewDelegate {
    func didChangeColor(to color: UIColor) {
        messageLabel.text = "Selected color is \(color.accessibilityName.capitalized)"
        messageLabel.textColor = color
    }
}
