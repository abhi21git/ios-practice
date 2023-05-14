//
//  CollectionCompositionLayoutController.swift.swift
//  Collectionview
//
//  Created by Simran Rout on 08/05/23.
//

import UIKit

// MARK: CollectionCompositionLayoutController.swift
final class CollectionCompositionLayoutController: UIViewController {

    private var titleLabel: GradientTextLabel = GradientTextLabel()
    private var collectionView: UICollectionView!
    
    private let cities: [Cities] = Cities.allCases
    
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
    
    private func setUpViews() {
        view.backgroundColor = .white
        setupTitleLabel()
        let collectionConstraints: [NSLayoutConstraint] = setupCollectionView()
        NSLayoutConstraint.activate(collectionConstraints)
    }
    
    private func setupTitleLabel() {
        titleLabel.text = " COMPOSITION LAYOUT "
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Helvetica-BoldOblique", size: 18)
        navigationItem.titleView = titleLabel
    }
    
    private func setupCollectionView() -> [NSLayoutConstraint] {
        let layout: UICollectionViewLayout = createFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = view.backgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(HeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "HeaderView")
        let constraints: [NSLayoutConstraint] = [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        return constraints
    }
    
    private func prepareAnimation() {
        let yTransformation = view.center.y - titleLabel.center.y
        titleLabel.transform = CGAffineTransform(translationX: 0, y: yTransformation)
        collectionView.transform = CGAffineTransform(translationX: 0, y: yTransformation)
    }
    
    private func performAnimation() {
        UIView.animate(withDuration: 0.3, delay: 0.2) { [weak self] in
            self?.titleLabel.transform = .identity
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        let index = indexPath.item % cities.count
        cell.configureCell(city: cities[index], index: indexPath.row)
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        guard let view = view as? HeaderView else { return }
        view.transform = CGAffineTransform(scaleX: 1, y: 0.01)
        UIView.animate(withDuration: 0.25) {
            view.transform = .identity
        }
    }
    
     func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? CollectionViewCell else { return }
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
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath)
        return headerView
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.bounds.width / 2, height: 200.0)
    }
}

// MARK: - Custom FlowLayout
extension CollectionCompositionLayoutController {
    func createFlowLayout() -> UICollectionViewCompositionalLayout {
        let short: LayoutItem = .fractionalSize(width: 1.0, height: 0.25)
                                .insets(top: 5, leading: 0, bottom: 5, trailing: 0)

        let tall: LayoutItem = .fractionalSize(width: 1.0, height: 0.5)
                               .insets(top: 5, leading: 0, bottom: 5, trailing: 0)

        let leftGroup = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                                           heightDimension: .fractionalHeight(1)),
                                                         subitems:  [short, short, tall])
        leftGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

        let rightGroup = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                                           heightDimension: .fractionalHeight(1)),
                                                         subitems:  [tall, short, short])
        rightGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

        let mainGroup = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                             heightDimension: .fractionalHeight(1)),
                                                           subitems: [leftGroup, rightGroup])
        mainGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let section = NSCollectionLayoutSection(group: mainGroup)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .fractionalHeight(0.3))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
        header.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 0, trailing: 10.0)
        
        section.boundarySupplementaryItems = [header]
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
