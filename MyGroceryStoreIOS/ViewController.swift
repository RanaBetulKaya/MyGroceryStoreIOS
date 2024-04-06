//
//  ViewController.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 31.03.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func signInButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc=storyboard.instantiateViewController(identifier: "signInView")
        vc.modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
    }
    @IBAction func signUpButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc=storyboard.instantiateViewController(identifier: "signUpView")
        vc.modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

