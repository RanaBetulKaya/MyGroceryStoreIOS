//
//  HomeViewController.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 1.04.2024.
//

import UIKit
import FirebaseFirestore

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    private var db = Firestore.firestore()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView{
        case categoryCollectionView:
            return categories.count
        case salesCollectionView:
            return populars.count
        default: return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView{
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            cell.setup(category: categories[indexPath.row])
            return cell
        case salesCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SalesCollectionViewCell.identifier, for: indexPath) as! SalesCollectionViewCell
            cell.setup(product: populars[indexPath.row])
            return cell
        default: return UICollectionViewCell()
        }
        
        
        
        
    }
    
    

    var categories: [HomeCategoryModel] = [
        .init(img_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8ycQho5biF0TZLGOuDtp2jStnUNAqqzlXhg&s", type: "Indian", name: "Aloo")
    ]
    
    var populars: [SaleProductModel] = [
        .init(campaign: "true", description: "%40 indirimli", img_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8ycQho5biF0TZLGOuDtp2jStnUNAqqzlXhg&s", name: "Islak Mendil", type: "cleaning", price: 36),
        .init(campaign: "true", description: "%40 indirimli", img_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8ycQho5biF0TZLGOuDtp2jStnUNAqqzlXhg&s", name: "Islak Mendil", type: "cleaning", price: 36),
        .init(campaign: "true", description: "%40 indirimli", img_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8ycQho5biF0TZLGOuDtp2jStnUNAqqzlXhg&s", name: "Islak Mendil", type: "cleaning", price: 36),
        .init(campaign: "true", description: "%40 indirimli", img_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8ycQho5biF0TZLGOuDtp2jStnUNAqqzlXhg&s", name: "Islak Mendil", type: "cleaning", price: 36),
        .init(campaign: "true", description: "%40 indirimli", img_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8ycQho5biF0TZLGOuDtp2jStnUNAqqzlXhg&s", name: "Islak Mendil", type: "cleaning", price: 36),
        .init(campaign: "true", description: "%40 indirimli", img_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8ycQho5biF0TZLGOuDtp2jStnUNAqqzlXhg&s", name: "Islak Mendil", type: "cleaning", price: 36)
    ]
    // fetch data
    
        
        /*do {
          let querySnapshot = try await db.collection("HomeCategory").getDocuments()
          for document in querySnapshot.documents {
              var category: HomeCategoryModel
              let data = document.data()
              let name = data["name"] as? String ?? ""
              let type = data["type"] as? String ?? ""
              let img_url = data["img_url"] as? String ?? ""
              
              category.img_url = img_url
              category.name = name
              category.type = type
              
              categories.append(category)
          }
        } catch {
          print("Error getting documents: \(error)")
        }*/
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var salesCollectionView: UICollectionView!
    
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        registerCells()
        
        
        // Home Category
        db.collection("HomeCategory").addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error retreiving snapshots \(error!)")
                return
            }

            //print("Current data: \(snapshot.documents.map { $0.data() })")

            for document in snapshot.documents{
                print(document.data())
                //var category: HomeCategoryModel! = HomeCategoryModel()
                let data = document.data()
                let name = data["name"] as? String ?? ""
                let type = data["type"] as? String ?? ""
                let img_url = data["img_url"] as? String ?? ""
                
                //category.img_url = img_url
                //category.name = name
                //category.type = type
                
                self.categories.append(HomeCategoryModel(img_url: img_url, type: type, name: name))
                print("Veri cekti")
            }
        }
        
        // Home Sales of Week
        
        
        
        // Home 2 Buy 1 Pay Campaign
        
    }
    private func registerCells(){
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil),forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
        salesCollectionView.register(UINib(nibName: SalesCollectionViewCell.identifier, bundle: nil),forCellWithReuseIdentifier: SalesCollectionViewCell.identifier)
    }

}

