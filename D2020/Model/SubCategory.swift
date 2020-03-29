//
//  Country.swift
//  d2020
//
//  Created by MacBook Pro on 3/3/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import UIKit
struct SubCategoryModel: Codable {
    var status: Bool?
    var Categories: [Data]?
    
    struct Data: Codable {
        var id: Int?
        var name: String?
        var seen: Int?
        var desc: String?
        var image: String?
    }
}
