//
//  LoginViewController.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 31.03.2024.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var emailnput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 12, *) {
            // iOS 12 & 13: Not the best solution, but it works.
            passwordInput.textContentType = .oneTimeCode
        } else {
            // iOS 11: Disables the autofill accessory view.
            // For more information see the explanation below.
            emailnput.textContentType = .init(rawValue: "")
         passwordInput.textContentType = .init(rawValue: "")
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func signUpButton(_ sender: Any) {
        let storyboard=UIStoryboard(name: "Main", bundle: nil)
        let vc=storyboard.instantiateViewController(identifier: "signUpView")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    @IBAction func signInButton(_ sender: Any) {
        
        validateFields()
    }
    
    func validateFields(){
        signIn()
    }
    func signIn(){
        
        Auth.auth().signIn(withEmail: emailnput.text!, password: passwordInput.text!){ [weak self] authResult, err in guard let strongSelf = self else{return}
            if let err = err{
                print(err.localizedDescription)
                self!.showAlertMessage(title: "HATA", message: "Kullanıcı bilgilerini kontrol ediniz.")
            }
            else{
                    let storyboard=UIStoryboard(name: "Main", bundle: nil)
                    let vc=storyboard.instantiateViewController(identifier: "MainViewController")
                    vc.modalPresentationStyle = .overFullScreen
                    self!.present(vc,animated: true)
                    print(Auth.auth().currentUser!.uid)
            }
            
        }
    }

}
