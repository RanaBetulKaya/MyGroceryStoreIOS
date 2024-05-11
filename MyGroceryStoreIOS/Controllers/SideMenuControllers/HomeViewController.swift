//
//  HomeViewController.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 1.04.2024.
//

import UIKit
import FirebaseFirestore
import Kingfisher

class HomeViewController: UIViewController, UICollectionViewDataSource,  UICollectionViewDelegate, CategoryCellDelegate{
    
    private var db = Firestore.firestore()
     
    var categories: [HomeCategoryModel] = []
    
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
            
            // Do any additional setup after loading the view.
            sideMenuBtn.target = revealViewController()
            sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
            
            categoryCollectionView.dataSource=self
            categoryCollectionView.delegate=self
        
            // Home Category
            db.collection("HomeCategory").addSnapshotListener { querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error retreiving snapshots \(error!)")
                    return
                }
                
                for document in snapshot.documents{
                    print(document.data())
                    let data = document.data()
                    let name = data["name"] as? String ?? ""
                    let type = data["type"] as? String ?? ""
                    let img_url = data["img_url"] as? String ?? ""
                    
                    self.categories.append(HomeCategoryModel(img_url: img_url, type: type, name: name))
                    print("Veri cekti")
                }
                self.categoryCollectionView.reloadData()
            }
        
        
    }
    func didTapCategoryButton(category: HomeCategoryModel) {
        let destinationViewController = ListViewController()
        
        if let destinationViewController = navigationController?.viewControllers.first(where: { $0 is ListViewController }) as? ListViewController {
            
            destinationViewController.modalPresentationStyle = .fullScreen
            // Geri butonu
            let backButton = UIBarButtonItem()
            backButton.title = "Geri"
            backButton.tintColor = UIColor.systemGreen
            self.navigationItem.backBarButtonItem = backButton
            destinationViewController.category = category
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        cell.setup(with: categories[indexPath.row])
        
        cell.delegate = self // Delegate'i ayarla
        cell.isUserInteractionEnabled = true
        //cell.frame.origin = CGPoint(x: 20, y: 10)
        return cell
    }

}
