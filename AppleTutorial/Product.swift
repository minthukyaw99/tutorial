//
//  Product.swift
//  AppleTutorial
//
//  Created by Min thu Kyaw on 4/5/17.
//  Copyright © 2017 Min thu Kyaw. All rights reserved.
//

import Foundation

class Product {
    
    var price: Double?
    var artist: String?
    var description: String?
    var productImg: String?
    var itemType: String?
    var name: String?
    var manufacturer: String?
    var imageUrl: String?
    
    init(p price:Double,a artist:String,d description: String,proImg productImg: String,type itemType:String,n name:String,m manufacturer:String, imageUrl: String ){
        self.price = price
        self.artist = artist
        self.description = description
        self.productImg = productImg
        self.itemType = itemType
        self.name = name
        self.manufacturer = manufacturer
        self.imageUrl = imageUrl
    }
    
    
    
}
