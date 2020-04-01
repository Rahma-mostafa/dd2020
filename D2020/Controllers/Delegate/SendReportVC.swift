//
//  SendReportVC.swift
//  D2020
//
//  Created by MacBook Pro on 4/2/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class SendReportVC: BaseController {
    
    @IBOutlet weak var roundedView: UIView!
    
    @IBOutlet weak var pageView: UIView!
    
    @IBOutlet weak var sendLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var sendButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       //cornerRadius
        roundedView.layer.cornerRadius = 8
        pageView.layer.cornerRadius = 3
        textView.layer.cornerRadius = 8
        sendButton.layer.cornerRadius = 8
        //localization
        sendLabel.text = "report.title".localized
        
        sendButton.setTitle("report.send".localized, for: .normal)
        
    }
    
    @IBAction func onDismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onsendButtonTapped(_ sender: Any) {
    }
    
    
}
