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
    
    var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSizeMake(150.0, 150)
        layout.scrollDirection = .vertical
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    private func setUpViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.title = "Collection View"
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(placeName: cities[indexPath.item].name, imageName: cities[indexPath.item].image )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width
        return CGSize(width: collectionWidth / 2 - 8, height: collectionWidth / 2 - 8)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
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
