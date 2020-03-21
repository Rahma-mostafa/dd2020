//
//  Country.swift
//  d2020
//
//  Created by MacBook Pro on 3/3/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import UIKit
struct Country: Decodable {
    var status: Bool?
    var data: [CountryData]?
   
    struct CountryData: Decodable {
        var id: Int?
        var code: Int?
        var file: String?
        var name: String?
    }
}
