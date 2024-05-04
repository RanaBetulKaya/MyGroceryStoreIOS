//
//  ProfileViewController.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 7.04.2024.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ProfileViewController: UIViewController {
    
    var ref: DatabaseReference!


    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userTelTextField: UITextField!
    @IBOutlet weak var userAddressTextField: UITextField!
    
    
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Firebase veritabanı referansını oluştur
        ref = Database.database().reference(fromURL: "https://my-grocery-store-c4018-default-rtdb.europe-west1.firebasedatabase.app/")
        
        showInfo()
        // Do any additional setup after loading the view.
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
    }
    func showInfo(){
        ref.child("Users").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                   if let userData = snapshot.value as? [String: Any] {
                       // Kullanıcı verilerini al
                       let name = userData["name"] as? String ?? ""
                       let password = userData["password"] as? String ?? ""
                       let telephone = userData["phone"] as? String ?? ""
                       let address = userData["address"] as? String ?? ""
                       
                       // TextField'lara verileri yaz
                       self.userNameTextField.text = name
                       self.userPasswordTextField.text = password
                       self.userTelTextField.text = telephone
                       self.userAddressTextField.text = address
                   }
               }) { (error) in
                   print("Firebase veri alımı başarısız: \(error.localizedDescription)")
               }
        self.userNameTextField.reloadInputViews()
        self.userPasswordTextField.reloadInputViews()
        self.userTelTextField.reloadInputViews()
        self.userAddressTextField.reloadInputViews()
    }
    func updateUserData() {
            // Güncellenecek verileri al
            guard let newName = userNameTextField.text,
                  let newAddress = userAddressTextField.text,
                  let newPassword = userPasswordTextField.text,
        let newTelephone = userTelTextField.text else {
                return
            }
            
            // Yeni verileri Firebase veritabanına güncelle
            let userData = ["name": newName,
                            "address": newAddress,
                            "password": newPassword,
                            "phone": newTelephone,]
            
        ref.child("Users").child(Auth.auth().currentUser!.uid).updateChildValues(userData) { (error, ref) in
                if let error = error {
                    print("Firebase veri güncelleme hatası: \(error.localizedDescription)")
                } else {
                    print("Kullanıcı bilgileri güncellendi")
                }
            }
        }
    @IBAction func updateBtn(_ sender: Any) {
        updateUserData()
        self.userNameTextField.reloadInputViews()
        self.userPasswordTextField.reloadInputViews()
        self.userTelTextField.reloadInputViews()
        self.userAddressTextField.reloadInputViews()
    }
}
