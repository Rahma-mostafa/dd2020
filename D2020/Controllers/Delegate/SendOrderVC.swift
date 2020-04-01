//
//  SendOrderVC.swift
//  D2020
//
//  Created by MacBook Pro on 4/1/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
//import KRProgressHUD


class SendOrderVC: BaseController {

    @IBOutlet weak var askLabel: UILabel!
    @IBOutlet weak var yourOrderTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var imageButton: UIImageView!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var noteDescLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yourOrderTextField.layer.cornerRadius = 11
        yourOrderTextField.shadowRadius = 11
        sendButton.layer.cornerRadius = 8
        
        
        setupLocalication()
    }
    func setupLocalication(){
        askLabel.text = "your.order".localized
        yourOrderTextField.attributedPlaceholder = NSAttributedString(string: "write.order".localized)
       sendButton.setTitle("send.order".localized, for: .normal)
        noteLabel.text = "note".localized
        noteDescLabel.text = "note.desc".localized
        

        
        
    }
    
    @IBAction func onSendButtonTapped(_ sender: Any) {
        imageButton.isHidden = true
//        KRProgressHUD.show()

        
    }
    

}
