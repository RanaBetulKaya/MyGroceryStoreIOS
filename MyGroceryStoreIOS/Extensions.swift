//
//  Extensions.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 2.04.2024.
//

import Foundation
import UIKit

extension UIViewController{
    
    public func showAlertMessage(title: String, message: String){
        
        let alertMessagePopUpBox = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Tamam", style: .default)
        
        alertMessagePopUpBox.addAction(okButton)
        self.present(alertMessagePopUpBox, animated: true)
    }
    
}
extension String{
    var asURL: URL?{
        return URL(string: self)
    }
}
