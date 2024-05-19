//
//  RegistrationViewController.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 31.03.2024.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegistrationViewController: UIViewController {

    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var telephone: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var userName: UITextField!
    
    var ref: DatabaseReference!
    
    @IBAction func signUp(_ sender: Any) {
        if email.text?.isEmpty == true{
            print("No text in email field")
            return
        }
        if password.text?.isEmpty == true{
            print("No text in password field")
            return
        }
            signUp()
    }
    @IBAction func signInButton(_ sender: Any) {
        let storyboard=UIStoryboard(name: "Main", bundle: nil)
        let vc=storyboard.instantiateViewController(identifier: "signInView")
        vc.modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ref = Database.database().reference(fromURL: "https://my-grocery-store-c4018-default-rtdb.europe-west1.firebasedatabase.app/")
    }
    func signUp(){
        Auth.auth().createUser(withEmail: email.text!, password: password.text!){
            (authResult,error)in guard let user = authResult?.user, error == nil else{
                print("Error \(error?.localizedDescription)")
                return
            }
            
            if(self.email.text==" "){
                self.showAlertMessage(title: "HATA!", message: "Email adresini boş bırakamazsınız.")
            }
            if(self.password.text==" "){
                self.showAlertMessage(title: "HATA!", message: "Şifre alanını boş bırakamazsınız.")
            }
            else{
                let userData=["address":self.address.text,
                              "budget":0,
                              "mail":self.email.text,
                              "name":self.userName.text,
                              "password":self.password.text,
                              "phone":self.telephone.text]
                let userRef = self.ref.child("Users").child(Auth.auth().currentUser!.uid)
                userRef.setValue(userData){ error, _ in
                    if let error = error {
                        print("Veri eklenirken hata oluştu: \(error.localizedDescription)")
                    } else {
                        print("Kullanıcı verisi başarıyla eklendi")
                        self.showAlertMessage(title: "Kayıt Alındı", message: "Kaydınız alındı. Sisteme giriş yapabilirsiniz.")
                    }
                }
            }
        }
    }

}
