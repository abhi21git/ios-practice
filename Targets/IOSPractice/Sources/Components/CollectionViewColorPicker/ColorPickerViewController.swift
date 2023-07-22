//
//  ColorPickerViewController.swift
//  IOSPractice
//
//  Created by Simran Rout on 22/07/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import UIKit
import IOSPracticeUI

class ColorPickerViewController: UIViewController {
  
    lazy private var color: [UIColor] = getRandomColors()
    lazy private var collectionView: ColorCollectionView = ColorCollectionView(color: color)
    private var colorPickedView: UIView = UIView()
    
    // MARK: Lifecycle
    convenience init(title: String) {
        self.init()
        setupNavTitle(title)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func getRandomColors() -> [UIColor] {
        var colors: [UIColor] = []
        for _ in 0...20 {
            colors.append(UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1) )
        }
        return colors
    }
}

//MARK: - Setup views
extension ColorPickerViewController: UICollectionViewDelegateFlowLayout {
    
    private func setupViews() {
        view.backgroundColor = .white
        let collectionConstraints: Constraints = setupCollectionView()
        let colorPickedViewConstraint: Constraints = setupColorPickedView()
        (collectionConstraints + colorPickedViewConstraint).activate()
    }
    
    private func setupColorPickedView() -> Constraints {
        colorPickedView.cornerRadius(16.0)
        colorPickedView.backgroundColor = .purple
        colorPickedView.layer.borderColor = UIColor.white.cgColor
        colorPickedView.layer.borderWidth = 2.0
        colorPickedView.layer.shadowColor = UIColor.black.cgColor
        colorPickedView.layer.shadowRadius = 8
        colorPickedView.layer.shadowOpacity = 0.4
        colorPickedView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
        colorPickedView.layer.masksToBounds = false
        let constraint: Constraints = view.addSubview(colorPickedView, with: [.centerX(from: collectionView.centerXAnchor) ,
                                                                              .centerY(from: collectionView.centerYAnchor),
                                                                              .aspectRatio(),
                                                                              .height(constant: -10, equalTo: collectionView.heightAnchor) ])
        return constraint
    }
    
    private func setupCollectionView() -> Constraints {
        let constraint: Constraints = view.addSubview(collectionView, considerSafeArea: true, with: [.leading(constant: 20.0),
                                                                                                     .trailing(constant: 20.0),
                                                                                                     .top(constant: 20.0),
                                                                                                     .height(constant: 80.0)])
        return constraint
    }
    
    private func setupNavTitle(_ title: String) {
        let titleLabel: GradientTextLabel = GradientTextLabel()
        titleLabel.text = " \(title) "
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Helvetica-BoldOblique", size: 18)
        navigationItem.titleView = titleLabel
    }
}
