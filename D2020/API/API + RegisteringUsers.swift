//
//  API + RegisteringUsers.swift
//  D2020
//
//  Created by Macbook on 3/23/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//extension API {
//    class func users(completion: @escaping (_ error:Error?,_ users: [Users]?)->Void){
//
//        let url = "\(URLs.users)/\(String(CountryViewController.deviceCountry?.id ?? 0))"
//
////        guard let api_token = UserDefaultsHelper.getapiApiToken() else{
////            completion(nil,nil)
////            return
////        }
//
//        let headers = [
//            "lang" : "ar",
//            " Country_id" : String(CountryViewController.deviceCountry?.id ?? 0)
//
//            ] as [String : String]
//
//        var userData : [Users] = []
        
        
        
//        Alamofire.request(url, method: .get,parameters: nil,encoding: URLEncoding.default, headers: headers )
//            .responseJSON { response in
//
//                switch response.result
//                {
//                case .failure(let error) :
//
//                    completion(error,nil)
//                    print(error)
//
//                case .success(let value) :
//                    let json = JSON(value)
//                    print(json)
//                    guard let dataArr = json["data"]["Sections"].array else {
//
//                        completion(nil,nil)
//                        return
//                    }
//                    var users = [Users]()
//                    for data in dataArr {
//                        guard let data = data.dictionary else {return}
//
//                        let user = Users()
//                        user.id = data["id"]?.int ?? 0
//                        user.name = data["name"]?.string ?? ""
//                        user.registerLike = data["registerLike"]?.string ?? ""
//                        user.image = data["image"]?.string ?? ""
//                        user.color = data["color"]?.string ?? ""
//                        user.style = data["style"]?.int ?? 0
//
//                        users.append(user)
//
//                    }
//                    completion(nil,users)
//                }
//        }
        
        
        
        
//        Alamofire.request(url, method: .get, headers: headers).responseJSON(completionHandler: { (response) in
//
//            switch response.result {
//
//            case .success(let value):
//                let json = JSON(value)
//                let data = json["data"]
//                data["Sections"].array?.forEach({ (user) in
//                    let user = Users(id: user["id"].intValue, name: user["name"].stringValue, style: user["style"].intValue, registerLike: user["registerLike"].stringValue, image: user["image"].stringValue, color: user["color"].stringValue)
//
//                    var userData : [Users] = []
//
//
//                    userData.append(user)
//
//                })
//
//
//
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//
//        })
//
//    }

    
    
//}

