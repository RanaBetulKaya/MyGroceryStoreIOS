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
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        cell.setup(category: categories[indexPath.row])
        return cell
    }
    
    

    var categories: [HomeCategoryModel] = []
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
    
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        registerCells()
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
        
    }
    private func registerCells(){
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil),forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }

}

