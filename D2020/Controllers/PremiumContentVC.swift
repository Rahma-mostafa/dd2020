//
//  PremiumContentVC.swift
//  D2020
//
//  Created by Macbook on 3/3/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class PremiumContentVC: UIViewController {
    
    var PaageIndex = 0
    var ImmageName : String?

    @IBOutlet weak var promoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentImage = ImmageName {
                          promoImageView.image = UIImage(named: currentImage)
                      }

       
    }
    
    
    

    

}
