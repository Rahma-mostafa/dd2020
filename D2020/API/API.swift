//
//  API.swift
//  D2020
//
//  Created by Macbook on 3/22/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API: NSObject {
    
    class func login(phone:String,password:String,completion: @escaping (_ error:Error?,_ success:Bool)->Void) {
         
        let url = URLs.register
         
        let parameters = [
            "username": phone,
            "password": password
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result {
                    
                case .failure(let error):
                    completion(error,false)
                    print(error)
                     
                case .success(let value):
                    let json = JSON(value)
                    
                    if let api_token = json["data"].string {
                        
                        print("data: \(api_token)")
                        
                        //save api token to userDefaults
                        UserDefaultsHelper.saveApiToken(token: api_token)
                        
                          
                        completion(nil,true)
                        
                    }
                    
                }
        }
        
        
    }

    
    
    class func regisetr(phone:String,email:String,name:String,password:String,confirmPassword:String,completion: @escaping (_ error:Error?,_ success:Bool)->Void) {
            
            
            let url = URLs.register
                           
        let parameters = [
            "phone": phone,
            "password":password ,
            "email" : email,
            "name": name,
            "password_confirmation" :confirmPassword
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result {
               
                case .failure(let error):
                    print(error)
                    
                case .success(let value):
                    let json = JSON(value)
                    if let api_token = json["data"]["user"].string {
                        print("user: \(api_token)")
                        //save api token to userDefaults
                        UserDefaultsHelper.saveApiToken(token: api_token)
                        completion(nil,true)
                    }
                }
        }
    }
}
