//
//  HomeViewController.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 1.04.2024.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
    }

}
