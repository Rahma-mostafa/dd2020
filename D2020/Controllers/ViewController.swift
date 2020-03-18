//
//  ViewController.swift
//  D2020
//
//  Created by Macbook on 2/13/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //showing password
    var isSecure = true


    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
//        loginPressed outlet for disable btn & it's gray color
    @IBOutlet weak var loginPressedOutlet: RoundedButton!
    
    @IBOutlet weak var imgCall: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loginPressedOutlet.isEnabled = false
//        imgCall.layer.cornerRadius = 33

    }
    
    
   //showing password
    @IBAction func showPassword(_ sender: Any) {
        
        isSecure = !isSecure
               password.isSecureTextEntry = isSecure
        
        
    }
    
    
    
    
    
    @IBAction func loginPressed(_ sender: Any) {
        loginPressedOutlet.isEnabled = false
        

    }
   
    
    @IBAction func textDidChange(_ sender: UITextField) {
         
        if (email.text!.count>0  && password.text!.count>0 ) {
            loginPressedOutlet.isEnabled = true
            
            loginPressedOutlet.backgroundColor = .systemOrange
           
//            imgCall.tintColor = .gray

        }else {
            loginPressedOutlet.isEnabled = false
            
            loginPressedOutlet.backgroundColor = .gray
            

            
            
            
        }
    }
    
    
    
    
}

