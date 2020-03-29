//
//  Country.swift
//  d2020
//
//  Created by MacBook Pro on 3/3/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import UIKit
struct CityModel: Codable {
    var status: Bool?
    var data: [CityData]?
   
    struct CityData: Codable {
        var id: Int?
        var code: String?
        var file: String?
        var name: String?
    }
}
