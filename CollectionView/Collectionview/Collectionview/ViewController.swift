//
//  ViewController.swift
//  Collectionview
//
//  Created by Simran Rout on 08/05/23.
//

import UIKit

class ViewController: UIViewController {

    private var cities : [City] = [ City(image: "Ankara", name: "Ankara"),
                                    City(image: "Antalya", name: "Antalya"),
                                    City(image: "Aydin", name: "Aydin"),
                                    City(image: "Bodrum", name: "Bodrum"),
                                    City(image: "Canakkale", name: "Canakkale"),
                                    City(image: "Cappadocia", name: "Cappadocia"),
                                    City(image: "Efes", name: "Efes"),
                                    City(image: "Eskisehir", name: "Eskisehir"),
                                    City(image: "Fethiye", name: "Fethiye"),
                                    City(image: "Istanbul", name: "Istanbul"),
                                    City(image: "Izmir", name: "Izmir"),
                                    City(image: "Mardin", name: "Mardin"),
                                    City(image: "Nemrut", name: "Nemrut"),
                                    City(image: "Pamukkale", name: "Pamukkale"),
                                    City(image: "Patara", name: "Patara"),
                                    City(image: "Rize", name: "Rize"),
                                    City(image: "Salda", name: "Salda"),
                                    City(image: "Sumela", name: "Sumela")]
    
    var collectionView: UICollectionView!
    
    override func loadView() {
        super.loadView()
        let layout: UICollectionViewCompositionalLayout = createFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    private func setUpViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(HeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "HeaderView")
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension ViewController: UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(placeName: cities[indexPath.item].name, imageName: cities[indexPath.item].image, index: indexPath.row)
        return cell
    }
}

// MARK: - Custom FlowLayout
extension ViewController:  UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: "HeaderView",
                                                                         for: indexPath)
        return headerView
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: collectionView.bounds.width / 2, height: 200.0)
    }
    
}

// MARK: - Custom FlowLayout
extension ViewController {
    func createFlowLayout() -> UICollectionViewCompositionalLayout {
        /// item
        let short: LayoutItem = .fractionalSize(width: 1.0, height: 0.25)
                                .insets(top: 0, leading: 0, bottom: 10, trailing: 0)

        let tall: LayoutItem = .fractionalSize(width: 1.0, height: 0.5)
                               .insets(top: 0, leading: 0, bottom: 10, trailing: 0)

        let leftGroup = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                                           heightDimension: .fractionalHeight(1)),
                                                         subitems:  [short, short, tall])
        leftGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

        let rightGroup = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                                           heightDimension: .fractionalHeight(1)),
                                                         subitems:  [tall, short, short])
        rightGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

        /// group
        let mainGroup = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                             heightDimension: .fractionalHeight(1)),
                                                           subitems: [leftGroup, rightGroup])
        mainGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        ///section
        let section = NSCollectionLayoutSection(group: mainGroup)
        return UICollectionViewCompositionalLayout(section: section)
    }
}

struct City {
    var image: String = ""
    var name: String = ""
    init(image: String, name: String) {
        self.image = image
        self.name = name
    }
}
