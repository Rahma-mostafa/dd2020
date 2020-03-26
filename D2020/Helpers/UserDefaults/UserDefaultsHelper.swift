//
//  UserDefaultsHelper.swift
//  D2020
//
//  Created by Macbook on 3/22/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class UserDefaultsHelper: NSObject {
    
    class func restartApp(){
        
        guard let window = UIApplication.shared.keyWindow else {return}
        
        let stoaryBoard = UIStoryboard(name: "Main", bundle: nil)
        
        var vc : UIViewController
        
        if getapiApiToken() == nil {
            //go to auth screen
            vc = stoaryBoard.instantiateInitialViewController()!
            
            
            
        }else{
            //go to home screen
            vc = stoaryBoard.instantiateViewController(withIdentifier: "home")
            
       
        }
        window.rootViewController = vc
        
        //if logged in 
        
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil,completion:nil)
    }
    
    class func saveApiToken(token:String){
           let def = UserDefaults.standard
           def.setValue(token, forKeyPath: "data")
           def.synchronize()
        
        restartApp()
}
    
    class func getapiApiToken() ->String? {
        
        let def = UserDefaults.standard
        return def.object(forKey: "data") as? String
            
        }
        
    }

