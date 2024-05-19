//
//  MyCartViewController.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 7.04.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase

class MyCartViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CartCollectionViewCellDelegate {
    
    var db = Firestore.firestore()
    var cartProducts: [MyCartModel] = []
    var ref: DatabaseReference!
    
    @IBOutlet weak var cartCollectionView: UICollectionView!
    
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    @IBAction func buynowBtn(_ sender: Any) {
        //sendNotification()
        clearCart()
        decreaseBudget()
    }
    func didTapDeleteButton(product: MyCartModel) {
        print("Fonk' a  girdikkkkkk")
        print("ürün id: " ,product.cartProductID)
        db.collection("CurrentUser").document(Auth.auth().currentUser!.uid).collection("AddToCart").document(product.cartProductID!).delete(){ error in
            if let error = error{
                self.showAlertMessage(title: "Hata", message: "Ürün silinmedi. Tekrar deneyiniz.")
            } else{
                self.showAlertMessage(title: "", message: "Ürün sepetten çıkarıldı.")
                // cartProducts dizisinden ürünü sil
                                if let index = self.cartProducts.firstIndex(where: { $0.cartProductID == product.cartProductID }) {
                                    let removedProduct = self.cartProducts.remove(at: index)
                                    
                                    // totalAmount'ı güncelle
                                    if let currentTotal = Int(self.totalAmountLabel.text ?? "0") {
                                        let newTotal = currentTotal - (removedProduct.totalPrice ?? 0)
                                        self.totalAmountLabel.text = "\(newTotal)"
                                    }
                                }
                           // Collection view'i güncelle
                           self.cartCollectionView.reloadData()
                           print("ürün silindi ve collection view güncellendi")
            }
            print("ürün silindi")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        cartCollectionView.delegate=self
        cartCollectionView.dataSource=self
        
        fetchProductData()
        
        ref = Database.database().reference(fromURL: "https://my-grocery-store-c4018-default-rtdb.europe-west1.firebasedatabase.app/")
    }
    func fetchProductData(){
        // Veri çekme
        
        var totalAmount = 0
        db.collection("CurrentUser").document(Auth.auth().currentUser!.uid).collection("AddToCart").getDocuments{ querySnapshot, error in guard let snapshot = querySnapshot else { print("Error retriving snapshots \(error!)")
            return
        }
            print("vt bağlandı")
            for document in snapshot.documents{
                print(document.data())
                let cartProductID = document.documentID
                let data = document.data()
                let productName = data["productName"] as? String ?? ""
                let totalQuantity = data["totalQuantity"] as? Int ?? 0
                let totalPrice = data["totalPrice"] as? Int ?? 0
                totalAmount+=totalPrice
                if !self.cartProducts.contains(where: { $0.cartProductID == cartProductID }) {
                self.cartProducts.append(MyCartModel(productName: productName, totalPrice: totalPrice, totalQuantity: totalQuantity, cartProductID: cartProductID))
                }
                
                print("for içinde")
            }
            self.totalAmountLabel.text = "\(totalAmount)"
            self.cartCollectionView.reloadData()
        //}
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cartCollectionView.dequeueReusableCell(withReuseIdentifier: "CartCollectionViewCell", for: indexPath) as! CartCollectionViewCell
        cell.setup(with: cartProducts[indexPath.row])
        cell.delegate = self
        print("cellForItemAt ")
        return cell
    }
    
    func clearCart() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let cartCollectionRef = db.collection("CurrentUser").document(userID).collection("AddToCart")
        
        cartCollectionRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                self.showAlertMessage(title: "Hata", message: "Sepet boşaltılamadı. Tekrar deneyiniz.")
            } else {
                let batch = self.db.batch()
                for document in querySnapshot!.documents {
                    batch.deleteDocument(document.reference)
                }
                batch.commit { (error) in
                    if let error = error {
                        print("Error deleting documents: \(error)")
                        self.showAlertMessage(title: "Hata", message: "Sepet boşaltılamadı. Tekrar deneyiniz.")
                    } else {
                        self.showAlertMessage(title: "", message: "Sepet başarıyla boşaltıldı.")
                        self.cartProducts.removeAll()
                        self.totalAmountLabel.text = "0"
                        self.cartCollectionView.reloadData()
                    }
                }
            }
        }
    }
    func decreaseBudget(){
        let totalAmountInt = Int(self.totalAmountLabel.text ?? "0")
        ref.child("Users").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value, with: {(snapshot) in
            if let userData = snapshot.value as? [String: Any]{
                let budget: Int = userData["budget"] as? Int ?? 0
                let newBudget = budget - totalAmountInt!
                
                let userData = ["budget": newBudget]
                print("fonk içinde yeni bütçe: \(newBudget)")
                
                self.ref.child("Users").child(Auth.auth().currentUser!.uid).updateChildValues(userData){(error, ref) in
                    if let error = error{
                        print("Firebase veri güncelleme hatası:\(error.localizedDescription)")
                    } else{
                        print("Kullanıcı bilgileri güncellendi")
                    }
                }
            }
        }){(error) in print("Firebase veri alımı başarısız: \(error.localizedDescription)")}
        
    }
    /*@objc func sendNotification() {
            // Bildirim içeriğini oluşturma
            let content = UNMutableNotificationContent()
            content.title = "Merhaba"
            content.body = "Bu bir bildirim mesajıdır."
            content.sound = UNNotificationSound.default
            
            // Bildirim tetikleyicisini oluşturma (örneğin, 5 saniye sonra tetiklensin)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            // Bildirim talebini oluşturma
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            // Bildirimi planlama
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Bildirim gönderilemedi: \(error.localizedDescription)")
                } else {
                    print("Bildirim gönderildi.")
                }
            }
        }*/

}
