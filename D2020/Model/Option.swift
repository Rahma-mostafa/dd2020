//
//  option.swift
//  D2020
//
//  Created by MacBook Pro on 3/16/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import Foundation

struct OptionFilter {
    enum FilterType {
        case nearest
        case top_rate
    }
    var name: String
    var type: FilterType
}
