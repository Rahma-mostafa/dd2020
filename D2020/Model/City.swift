//
//  City.swift
//  D2020
//
//  Created by MacBook Pro on 3/21/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import Foundation
struct City: Codable {
    let status: Bool?
    let data: [Datum]?
    let message: String?
    // MARK: - Datum
    struct Datum: Codable {
        let id, code: Int?
        let file: String?
        let name: String?
    }

}

