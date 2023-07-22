//
//  ColorCollectionView.swift
//  IOSPractice
//
//  Created by Simran Rout on 22/07/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import UIKit

public final class ColorCollectionView: UICollectionView {
    var colors: [UIColor]
    private let flowLayout = UICollectionViewFlowLayout()
    
    public init(frame: CGRect = .zero, color: [UIColor]) {
        flowLayout.minimumLineSpacing = 5.0
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.scrollDirection = .horizontal
        colors = color
        super.init(frame: frame, collectionViewLayout: flowLayout)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        delegate = self
        dataSource = self
        register(ColorCollectionViewCell.self)
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        backgroundColor = .white
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        makeCircularCorner()
    }
    
    public func getSize(multiplier: CGFloat = 4) -> CGFloat {
        min(bounds.height, bounds.width) - (flowLayout.minimumLineSpacing * multiplier)
    }
}

extension ColorCollectionView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        flowLayout.minimumLineSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        flowLayout.minimumInteritemSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = getSize()
        return CGSize(width: size, height: size)
    }
    
}

extension ColorCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colors.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ColorCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setColor(color: colors[indexPath.item])
        return cell
    }
}
