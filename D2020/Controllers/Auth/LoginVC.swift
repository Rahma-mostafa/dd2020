//
//  ViewController.swift
//  D2020
//
//  Created by Macbook on 2/13/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class LoginVC: BaseController {

    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginPressedOutlet: RoundedButton!
    @IBOutlet weak var d2020Lbl: UILabel!
    @IBOutlet weak var d2020DescLbl: UILabel!
    @IBOutlet weak var loginLbl: UILabel!
    @IBOutlet weak var forgetBtn: UIButton!
    @IBOutlet weak var registerBtn: RoundedButton!
    @IBOutlet weak var orLbl: UILabel!
    @IBOutlet weak var facebookBtn: RoundedButton!
    @IBOutlet weak var googleBtn: RoundedButton!
    @IBOutlet weak var skipLbl: UILabel!
    
    //showing password
    var isSecure = true
    
    override func viewDidLoad() {
        super.hiddenNav = true
        super.viewDidLoad()
        d2020Lbl.text = "d2020.lan".localized
        d2020DescLbl.text = "d2020Desc.lan".localized
        loginLbl.text = "login.lan".localized
        forgetBtn.setTitle("forgot.password.lan".localized, for: .normal)
        registerBtn.setTitle("register.lan".localized, for: .normal)
        orLbl.text = "orRegister.lan".localized
        facebookBtn.setTitle("facebook.lan".localized, for: .normal)
        googleBtn.setTitle("google.lan".localized, for: .normal)
        loginPressedOutlet.setTitle("login.lan".localized, for: .normal)
        skipLbl.text = "skip.lan".localized
        skipLbl.UIViewAction {
            guard let vc = UIStoryboard.init(name: Storyboards.main.rawValue, bundle: nil).instantiateInitialViewController() else { return }
            self.push(vc)
        }
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
            usernameTxt.attributedPlaceholder = NSAttributedString(string: "mobile.or.email.lan".localized, attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            passwordTxt.attributedPlaceholder = NSAttributedString(string: "password.lan".localized, attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            
            // text is entered
        } else {
            
            // remove keyboard
            self.view.endEditing(true)
            
            guard let phone = usernameTxt.text, !usernameTxt.text!.isEmpty else {return}
            guard let password = passwordTxt.text, !passwordTxt.text!.isEmpty else {return}
            
            startLoading()
            let paramters: [String: String] = ["username": phone, "password": password]
            ApiManager.instance.paramaters = paramters
            ApiManager.instance.connection(.login, type: .post) { (response) in
                self.stopLoading()
                let user = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
                UserRoot.save(response: response)
                guard let vc = UIStoryboard.init(name: Storyboards.main.rawValue, bundle: nil).instantiateInitialViewController() else { return }
                self.push(vc)
            }
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



