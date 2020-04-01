//
//  DelegateRateVC.swift
//  D2020
//
//  Created by MacBook Pro on 4/1/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import Cosmos

class DelegateRateVC: BaseController{
    
    @IBOutlet weak var roundedView: UIView!
    
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var delegateRateLabel: UILabel!
    
    @IBOutlet weak var delegateNameLabel: UILabel!
    
    @IBOutlet weak var RatingView: CosmosView!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var delegateImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //cornerRadius
        roundedView.layer.cornerRadius = 3
        roundedView.layer.cornerRadius = 8
        delegateImageView.layer.cornerRadius = 33
        confirmButton.layer.cornerRadius = 8
        delegateRateLabel.text = "delegate.rate".localized
        confirmButton.setTitle("rate.confirm".localized, for: .normal)
        
        
        
        

    }
    
    @IBAction func onDissmissButtonTapped(_ sender: Any) {
        self.dismiss(animated:true)
    }
    
    @IBAction func onConfirmButtonTapped(_ sender: Any) {
    }
    
}
