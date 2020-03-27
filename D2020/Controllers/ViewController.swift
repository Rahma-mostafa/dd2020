//
//  ViewController.swift
//  D2020
//
//  Created by Macbook on 2/13/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class LoginVC: BaseController {
    //showing password
    var isSecure = true
    
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    //        loginPressed outlet for disable btn & it's gray color
    @IBOutlet weak var loginPressedOutlet: RoundedButton!
    
    @IBOutlet weak var imgCall: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //        loginPressedOutlet.isEnabled = false
        //        imgCall.layer.cornerRadius = 33
        
    }
    
    
    //showing password
    @IBAction func showPassword(_ sender: Any) {
        
        isSecure = !isSecure
        passwordTxt.isSecureTextEntry = isSecure
        
        
    }
    
    
    
    
    @IBAction func RegisterClicked(_ sender: Any) {
        let vc = controller(RegisterAsVC.self, storyboard: .auth)
        
        //        vc.registerAS =
        
        push(vc)
        
    }
    
    @IBAction func login_click(_ sender: Any) {
        //        loginPressedOutlet.isEnabled = false
        
        // if no text entered
        if usernameTxt.text!.isEmpty || passwordTxt.text!.isEmpty {
            
            // red placeholders
            usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            
            
            makeAlert("Please Fill Out All Fields") {
                
            }
            
            // text is entered
        } else {
            
            // remove keyboard
            self.view.endEditing(true)
            
            guard let phone = usernameTxt.text, !usernameTxt.text!.isEmpty else
                
                
                
            {return}
            guard let password = passwordTxt.text, !passwordTxt.text!.isEmpty else {return}
            
            
        }
    }
    
    
    @IBAction func textDidChange(_ sender: UITextField) {
        
        if (usernameTxt.text!.count>0  && passwordTxt.text!.count>0 ) {
            loginPressedOutlet.isEnabled = true
            
            loginPressedOutlet.backgroundColor = .systemOrange
            
            //            imgCall.tintColor = .gray
            
        }else {
            loginPressedOutlet.isEnabled = false
            
            loginPressedOutlet.backgroundColor = .gray
            
            
            
            
            
        }
    }
    
    
    
    
}


