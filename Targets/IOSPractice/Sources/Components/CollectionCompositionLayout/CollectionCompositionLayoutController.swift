//
//  CollectionCompositionLayoutController.swift.swift
//  Collectionview
//
//  Created by Simran Rout on 08/05/23.
//

import IOSPracticeKit
import IOSPracticeUI
import UIKit

// MARK: CollectionCompositionLayoutController.swift
final class CollectionCompositionLayoutController: UIViewController {
    
    // MARK: Properties
    private var collectionView: UICollectionView!
    private let cities: [Cities] = Cities.allCases
    
    // MARK: Lifecycle
    convenience init(title: String) {
        self.init()
        setupNavTitle(title)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layoutIfNeeded()
        prepareAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performAnimation()
    }
}

// MARK: Methods
extension CollectionCompositionLayoutController {
    private func setUpViews() {
        view.backgroundColor = .white
        let collectionConstraints: Constraints = setupCollectionView()
        (collectionConstraints).activate()
    }
    
    private func setupNavTitle(_ title: String) {
        let titleLabel: GradientTextLabel = GradientTextLabel()
        titleLabel.text = " \(title) "
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Helvetica-BoldOblique", size: 18)
        navigationItem.titleView = titleLabel
    }
    
    private func setupCollectionView() -> Constraints {
        let layout: UICollectionViewLayout = CustomCollectionViewCompositionalLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        let constraints: Constraints = view.addSubview(collectionView,
                                                       considerSafeArea: true,
                                                       with: [.leading(),
                                                              .top(),
                                                              .trailing(),
                                                              .bottom()])
        collectionView.backgroundColor = view.backgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageCollectionViewCell.self)
        collectionView.register(ImageCollectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
        return constraints
    }
    
    private func prepareAnimation() {
        collectionView.transform = CGAffineTransform(translationX: 0, y: collectionView.center.y)
    }
    
    private func performAnimation() {
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.collectionView.transform = .identity
        }
    }
}

// MARK: UICollectionViewDataSource
extension CollectionCompositionLayoutController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cities.count * 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let index = indexPath.item % cities.count
        cell.configureCell(with: cities[index].getCellModel(), index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        guard let view = view as? ImageCollectionHeaderView else { return }
        view.transform = CGAffineTransform(scaleX: 1, y: 0.01)
        UIView.animate(withDuration: 0.25) {
            view.transform = .identity
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ImageCollectionViewCell else { return }
        let xMultiplier: CGFloat = (indexPath.row / 3) % 2 == 0 ? -1 : 1
        cell.transform = CGAffineTransform(translationX: cell.frame.width * xMultiplier, y: 0).scaledBy(x: 0.8, y: 0.8)
        cell.prepareForAnimation()
        UIView.animate(withDuration: 0.25, animations: {
            cell.transform = .identity
        }) { _ in
            cell.animateItems()
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension CollectionCompositionLayoutController:  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView: ImageCollectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.bounds.width / 2, height: 200.0)
    }
}


// MARK: ImageCollectionViewCellModelBuilder
extension Cities {
    func getCellModel() -> ImageCollectionCellModel {
        return ImageCollectionCellModel(title: name, image: UIImage(named: name))
    }
}
