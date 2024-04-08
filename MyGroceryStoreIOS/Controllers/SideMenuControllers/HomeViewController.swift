//
//  HomeViewController.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 1.04.2024.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        cell.setup(category: categories[indexPath.row])
        return cell
    }
    
    

    var categories: [HomeCategoryModel] = [
        .init(img_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaXdQXBbJ9RTvHeTm3fSi1A8SgvnLBTZyM7QkglXmeSw&s", name: "Süt Ürünleri", type: "desert"),
        .init(img_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaXdQXBbJ9RTvHeTm3fSi1A8SgvnLBTZyM7QkglXmeSw&s", name: "American Pancakes 2", type: "desert"),
        .init(img_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaXdQXBbJ9RTvHeTm3fSi1A8SgvnLBTZyM7QkglXmeSw&s", name: "American Pancakes 3", type: "desert")
        ,
        .init(img_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaXdQXBbJ9RTvHeTm3fSi1A8SgvnLBTZyM7QkglXmeSw&s", name: "American Pancakes 3", type: "desert"),
        .init(img_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaXdQXBbJ9RTvHeTm3fSi1A8SgvnLBTZyM7QkglXmeSw&s", name: "American Pancakes 3", type: "desert"),
        .init(img_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaXdQXBbJ9RTvHeTm3fSi1A8SgvnLBTZyM7QkglXmeSw&s", name: "American Pancakes 3", type: "desert"),
        .init(img_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaXdQXBbJ9RTvHeTm3fSi1A8SgvnLBTZyM7QkglXmeSw&s", name: "American Pancakes 3", type: "desert")
    ]
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        registerCells()
    }
    private func registerCells(){
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil),forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }

}

