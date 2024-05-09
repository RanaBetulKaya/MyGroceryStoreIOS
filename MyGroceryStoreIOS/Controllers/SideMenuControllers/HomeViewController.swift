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
     
    var categories: [HomeCategoryModel] = []
    
    var populars: [SaleProductModel] = []
    
    var campaign: [SaleProductModel] = []
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var salesCollectionView: UICollectionView!
    
    @IBOutlet weak var campaignCollectionView: UICollectionView!
    
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        campaignCollectionView.dataSource=self
        campaignCollectionView.delegate=self
        
        salesCollectionView.delegate=self
        salesCollectionView.dataSource=self
        
        categoryCollectionView.delegate=self
        categoryCollectionView.dataSource=self
        
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
                
                self.categories.append(HomeCategoryModel(img_url: img_url, type: type, name: name))
                print("Veri cekti")
            }
            self.categoryCollectionView.reloadData()
        }
        
        // Home Sales of Week
        db.collection("PopularProducts").addSnapshotListener{ querySnapshot, error in guard let snapshot = querySnapshot else{
            print("Error retriving snapshots \(error!)")
            return
        }
            for document in snapshot.documents{
                print(document.data())
                
                let data = document.data()
                let campaign = data["campaign"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let img_url = data["img_url"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let type = data["type"] as? String ?? ""
                let price = data["price"] as? Int
                
                self.populars.append(SaleProductModel(campaign: campaign, description: description, img_url: img_url, name: name, type: type, price: price))
                print ("indirim verisi çekildi")
            }
            self.salesCollectionView.reloadData()
        }
        
        
        // Home 2 Buy 1 Pay Campaign
        db.collection("AllProducts").whereField("campaign", isEqualTo: "true").addSnapshotListener{ querySnapshot, error in guard let snapshot = querySnapshot else{ print("Error retriving snapshots \(error!)")
            return
            }
            for document in snapshot.documents{
                print(document.data())
                let data = document.data()
                let campaign = data["campaign"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let img_url = data["img_url"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let type = data["type"] as? String ?? ""
                let price = data["price"] as? Int
                
                self.campaign.append(SaleProductModel(campaign: campaign, description: description, img_url: img_url, name: name, type: type, price: price))
            }
            self.campaignCollectionView.reloadData()
        }
        
    }
    private func registerCells(){
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil),forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
        salesCollectionView.register(UINib(nibName: SalesCollectionViewCell.identifier, bundle: nil),forCellWithReuseIdentifier: SalesCollectionViewCell.identifier)
        
        campaignCollectionView.register(UINib(nibName: CampaignCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CampaignCollectionViewCell.identifier)
    }
    
    /*func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vc?.product = campaign[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    */
    
    
    /*func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
                // Ürün adını ve diğer gerekli bilgileri detay view controller'a geçir
                detailVC.product = products[indexPath.item]
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }*/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView{
        case categoryCollectionView:
            return categories.count
        case salesCollectionView:
            return populars.count
        case campaignCollectionView:
            return campaign.count
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
       case campaignCollectionView:
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CampaignCollectionViewCell.identifier, for: indexPath) as! CampaignCollectionViewCell
           
           cell.setup(product: campaign[indexPath.row])
           return cell
       default: return UICollectionViewCell()
       }
       
       
       
       
   }
    
    /*func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == salesCollectionView { // Eğer ürün hakkında özet gösteren collection view ise
            // Seçilen ürünün detaylarını göstermek için DetailViewController'a geçiş yap
            let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            // DetailViewController'a gönderilecek verileri belirle (örneğin, seçilen ürünün ID'si gibi)
            detailVC.product = populars[indexPath.item] // Örnek olarak products dizisinden ürün ID'sini gönderiyoruz
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }*/
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            
        }else{
            let controller = DetailViewController.instantiate()
            controller.product = collectionView == salesCollectionView ? populars[indexPath.row] : campaign[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        }
    }

}

