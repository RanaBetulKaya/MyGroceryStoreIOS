//
//  MyWalletViewController.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 7.04.2024.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class MyWalletViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    
    @IBOutlet weak var viewBudgetLabel: UILabel!
    @IBOutlet weak var addingAmountInput: UITextField!
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view.
        ref = Database.database().reference(fromURL: "https://my-grocery-store-c4018-default-rtdb.europe-west1.firebasedatabase.app/")
        
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        viewBudget()
        self.viewBudgetLabel.reloadInputViews()
    }

    /*func addMoney(){
        
        guard let addingAmount = addingAmountInput.text else{
            return
        }
        var intAddingAmount: Int = Int(addingAmount)!
        var budget: Int = 0
        ref.child("Users").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let userData = snapshot.value as? [String: Any] {
                // Kullanıcı verilerini al
                budget = userData["budget"] as! Int
                
            }
            }) { (error) in
                print("Firebase veri alımı başarısız: \(error.localizedDescription)")
            }
        var newBudget = budget + intAddingAmount
        
        let userData = ["budget": newBudget]
        
        ref.child("Users").child(Auth.auth().currentUser!.uid).updateChildValues(userData) { (error, ref) in
                if let error = error {
                    print("Firebase veri güncelleme hatası: \(error.localizedDescription)")
                } else {
                    print("Kullanıcı bilgileri güncellendi")
                }
            }
        
    }*/
    func addMoney() {
        guard let addingAmount = addingAmountInput.text,
              let intAddingAmount = Int(addingAmount) else {
            return
        }
        
        ref.child("Users").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let userData = snapshot.value as? [String: Any] {
                // Kullanıcı verilerini al
                if let budget = userData["budget"] as? Int {
                    let newBudget = budget + intAddingAmount
                    let userData = ["budget": newBudget]
                    
                    self.ref.child("Users").child(Auth.auth().currentUser!.uid).updateChildValues(userData) { (error, ref) in
                        if let error = error {
                            print("Firebase veri güncelleme hatası: \(error.localizedDescription)")
                        } else {
                            print("Kullanıcı bilgileri güncellendi")
                        }
                    }
                }
            }
        }) { (error) in
            print("Firebase veri alımı başarısız: \(error.localizedDescription)")
        }
    }

    func viewBudget(){
        ref.child("Users").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let userData = snapshot.value as? [String: Any] {
                
                let budget: Int = userData["budget"] as? Int ?? 0
                
                let stringBudget: String = String(budget)
                
                self.viewBudgetLabel.text = stringBudget + "₺"
                
            }
            }) { (error) in
                print("Firebase veri alımı başarısız: \(error.localizedDescription)")
            }
    }
    
    @IBAction func addMoneyBtn(_ sender: Any) {
        addMoney()
        self.viewBudgetLabel.reloadInputViews()
    }
    
}
