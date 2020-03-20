//
//  LoginVC.swift
//  D2020
//
//  Created by Macbook on 3/18/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
//import SwiftyJSON
import Alamofire


class LoginVC: UIViewController {
    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func loginPressed(_ sender: Any) {
    
    //         if no text entered
//            if phoneNumber.text!.isEmpty || password.text!.isEmpty {
//
//                // red placeholders
//                phoneNumber.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
//                password.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
//
//            // text is entered
//            } else {
    guard let phone = phoneNumber.text, !phone.isEmpty else { return }
                  
        guard let password = password.text, !password.isEmpty else { return }
  

        let url = "http://88.198.111.81/api/login"
                
                        
        let Parameters = ["username": phone,
        "password": password]
        
        AF.request(url,method: .post,parameters: Parameters,encoding: URLEncoding.default,headers: nil)
            .validate(statusCode: 200 ..< 300)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    print(error)
                case.success(let value):
                    
                    print(value)
                }
                
        }
        
//}
}
}
