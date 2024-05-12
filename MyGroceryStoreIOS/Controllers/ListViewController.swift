//
//  ListViewController.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 10.05.2024.
//

import UIKit
import FirebaseFirestore

class ListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, ProductListViewCellDelegate {
    func didTapDetailButton(product: SaleProductModel) {
        let destinationViewController = DetailViewController()
        
        if let destinationViewController = navigationController?.viewControllers.first(where: { $0 is DetailViewController }) as? DetailViewController {
            
            destinationViewController.modalPresentationStyle = .fullScreen
            // Geri butonu
            let backButton = UIBarButtonItem()
            backButton.title = "Geri"
            backButton.tintColor = UIColor.systemGreen
            self.navigationItem.backBarButtonItem = backButton
            destinationViewController.product = product
        }
    }
    
    
    @IBOutlet weak var productListCollectionView: UICollectionView!
    
    private var db = Firestore.firestore()
    
    var productList: [SaleProductModel] = []
    var category: HomeCategoryModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        productListCollectionView.dataSource=self
        productListCollectionView.delegate=self
        
        
        // DB işlemleri
        print(category.type)
        db.collection("AllProducts").whereField("type", isEqualTo: category.type).addSnapshotListener{ querySnapshot, error in guard let snapshot = querySnapshot else{ print("Error retriving snapshots \(error!)")
                return
            }
                for document in snapshot.documents{
                    print(document.data())
                    let data = document.data()
                    let documentID = document.documentID
                    let campaign = data["campaign"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let img_url = data["img_url"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let type = data["type"] as? String ?? ""
                    let price = data["price"] as? Int
                    print(data["name"])
                    print(documentID)
                    self.productList.append(SaleProductModel(campaign: campaign, description: description, img_url: img_url, name: name, type: type, price: price, documentID: documentID))
                }
                self.productListCollectionView.reloadData()
            //}
        }
        print("Girdik")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productListCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCollectionViewCell", for: indexPath) as! ProductListCollectionViewCell
        cell.setup(with: productList[indexPath.row])
        cell.isUserInteractionEnabled = true
        cell.delegate = self
        return cell
    }
}
