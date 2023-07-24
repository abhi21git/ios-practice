//
//  ColorCollectionView.swift
//  IOSPractice
//
//  Created by Simran Rout on 22/07/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import UIKit

public protocol ColorCollectionViewDelegate: AnyObject {
    func didChangeColor(to color: UIColor)
}

public final class ColorCollectionView: UICollectionView {
    public weak var colorDelegate: ColorCollectionViewDelegate?
    var colors: [UIColor]
    private let flowLayout = CollectionSnapFlowLayout()
    
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
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        backgroundColor = .clear
        register(ColorCollectionViewCell.self)
    }
    
    public func getSize(multiplier: CGFloat = 4) -> CGFloat {
        min(bounds.height, bounds.width) - (flowLayout.minimumLineSpacing * multiplier)
    }
}

extension ColorCollectionView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        flowLayout.minimumLineSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        flowLayout.minimumInteritemSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = getSize()
        return CGSize(width: size, height: size)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let halfSize = getSize() / 2
        return UIEdgeInsets(top: 0, left: frame.halfWidth - halfSize , bottom: 0, right: frame.halfWidth - halfSize)//flowLayout.minimumLineSpacing * 2)
    }
}

extension ColorCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colors.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ColorCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configureCell(with: colors[indexPath.item])
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let index = indexPathForItem(at: scrollView.offset.center) else {
            return
        }
        colorDelegate?.didChangeColor(to: colors[index.item])
    }
}

