//
//  SendOrderVC.swift
//  D2020
//
//  Created by Ahmad Shraby on 3/20/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class SendOrderVC: UIViewController {

    @IBOutlet weak var sendView: RoundedShadowView!
    @IBOutlet weak var orderTxtView: UITextView!
    @IBOutlet weak var sendBtn: RoundedButton!
    
    @IBOutlet weak var btnLbl: UILabel!
    @IBOutlet weak var btnImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        prepareBackgroundView()
    }
    
    func prepareBackgroundView(){
        sendView.layer.borderWidth = 0.5
        sendView.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        sendView.layer.cornerRadius = 20
        sendView.layer.shadowOffset = CGSize(width: 0, height: 1)
        sendView.layer.shadowColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        sendView.layer.shadowRadius = 1
        
        orderTxtView.layer.borderWidth = 0.5
        orderTxtView.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        orderTxtView.layer.cornerRadius = 20
        orderTxtView.layer.shadowOffset = CGSize(width: 0, height: 1)
        orderTxtView.layer.shadowColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        orderTxtView.layer.shadowRadius = 1
    }
    
    @IBAction func sendBtn(_ sender: Any) {
        
        btnLbl.text = "يتم ارسال طلبك"
        btnImage.loadingIndicator(true, nil)
        
//        btnLbl.text = "تم ارسال طلبك بنجاح"
//        btnImage.loadingIndicator(false, UIImage(named: "check (1)"))
        
    }
    

}
