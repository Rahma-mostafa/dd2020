//
//  Users.swift
//  D2020
//
//  Created by Macbook on 3/23/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

struct RegisterAs: Codable {
    let status: Bool
    let data: [RegisterAsData]
    let message: String

struct RegisterAsData: Codable {
    let id: Int
    let name: String
    let style: Int
    let registerLike, color: String
    let image: String
    }
}
