//
//  Config.swift
//  D2020
//
//  Created by Macbook on 3/22/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import Foundation


struct URLs {
    
    static let main = "http://88.198.111.81/api/"
    
    // POST {phoneNumber, Password}
    
    
    static let login = main + "login"
    
    // POST {phoneNumber, Password, confirmPass,....etc}
    static let register = main + "Register"
    
    
    // Get {api_token, page, per_page}
    static let users = main + "getSections"

}
