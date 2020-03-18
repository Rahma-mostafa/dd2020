//
//  products.swift
//  d2020
//
//  Created by MacBook Pro on 2/22/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import Foundation
class Products{
    var image: String
    var name: String
    var price:String?
    init(image: String ,name: String ,price:String){
        self.image = image
        self.name = name
        self.price = price
    }
}
