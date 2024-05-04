//
//  LogoutViewController.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 4.05.2024.
//

import UIKit
import FirebaseAuth

class LogoutViewController: UIViewController {

    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    
    @IBAction func logoutBtn(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            let storyboard=UIStoryboard(name: "Main", bundle: nil)
            let vc=storyboard.instantiateViewController(identifier: "signInView")
            vc.modalPresentationStyle = .overFullScreen
            present(vc,animated: true)
        }catch{
            print("already logged out")
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        // Do any additional setup after loading the view.
    }

}
