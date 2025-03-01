//
//  ColorCollectionView.swift
//  IOSPractice
//
//  Created by Simran Rout on 22/07/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import UIKit

@MainActor
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
        if let color = colors.first {
            colorDelegate?.didChangeColor(to: color)
        }
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
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let index = indexPathForItem(at: scrollView.offset.center) else { return }
        colorDelegate?.didChangeColor(to: colors[index.item])
        for cell in visibleCells {
            UIView.animate(withDuration: 0.2) { [weak self] in
                if self?.indexPathForItem(at: scrollView.offset.center) == self?.indexPath(for: cell) {
                    cell.addBorder(width: 2, colour: .white)
                    cell.addShadow(radius: 8, colour: .darkGray, opacity: 0.4)
                    cell.transform = .identity
                } else {
                    cell.addBorder(width: 0, colour: .white)
                    cell.addShadow(radius: 8, colour: .darkGray, opacity: 0)
                    cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                }
            }
        }
    }
}

// MARK: - Preview
#Preview(ColorCollectionView.name, traits: ColorCollectionView.traits, body: ColorCollectionView.preview)
extension ColorCollectionView: PreviewBuilderProtocol {
    public static var buildPreview: UIView {
        let view = ColorCollectionView(color: (1...80).map({ _ in UIColor.randomColor }))
        view.heightAnchor.constraint(equalToConstant: 80).isActive = true
        view.addShadow(radius: 3, colour: .darkGray, opacity: 0.2, offset: .zero)
        view.addBorder(width: 1, colour: .white)
        view.layer.cornerRadius = 40
        view.clipsToBounds = true
        return view
    }
}
