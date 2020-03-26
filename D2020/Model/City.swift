//
//  City.swift
//  D2020
//
//  Created by MacBook Pro on 3/21/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import Foundation

struct CityModel: Codable {
    let status: Bool?
    let data: [City]?
    let message: String?
}


struct City: Codable {
    let id: Int?
    let name: String?
    let code: String?
    let image: String?
}

