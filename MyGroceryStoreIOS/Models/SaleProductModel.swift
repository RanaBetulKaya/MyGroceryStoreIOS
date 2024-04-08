//
//  PopularProducts.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 8.04.2024.
//

import Foundation

struct SaleProductModel{
    var campaign: String?
    var description: String?
    var img_url: String?
    var name: String?
    var type: String?
    var price: Int?
    
    var formattedPrice:String{
        return String(format: "%d", price ?? 0)
    }
}
