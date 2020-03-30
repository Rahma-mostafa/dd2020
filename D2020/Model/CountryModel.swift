//
//  Country.swift
//  d2020
//
//  Created by MacBook Pro on 3/3/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import UIKit
struct Country: Codable {
    var status: Bool?
    var data: [CountryData]?
   
    struct CountryData: Codable {
        var id: Int?
        var code: String?
        var file: String?
        var name: String?
        var currency: String?
    }
}
