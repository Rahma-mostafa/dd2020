//
//  PromoContentVC.swift
//  D2020
//
//  Created by Macbook on 2/18/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class PromoContentVC: UIViewController {
    
    
    // Mark: - IBOutlet
    
    //variables
    var pageIndex = 0
    var imageName : String?
    var titleImage : String?
    var descImage : String?
   
    
    
    @IBOutlet weak var promoImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentImage = imageName {
            promoImageView.setImage(url: currentImage)
        }
        name.text = titleImage
        desc.text = descImage
    }
 
}

