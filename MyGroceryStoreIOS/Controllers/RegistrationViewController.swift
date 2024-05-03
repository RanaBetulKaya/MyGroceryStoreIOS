//
//  RegistrationViewController.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 31.03.2024.
//

import UIKit
import Firebase
import FirebaseAuth

class RegistrationViewController: UIViewController {

    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var telephone: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var userName: UITextField!
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
    }
    func signUp(){
        Auth.auth().createUser(withEmail: email.text!, password: password.text!){
            (authResult,error)in guard let user = authResult?.user, error == nil else{
                print("Error \(error?.localizedDescription)")
                return
            }
        }
        let storyboard=UIStoryboard(name: "Main", bundle: nil)
        let vc=storyboard.instantiateViewController(identifier: "signInView")
        vc.modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
    }

}
