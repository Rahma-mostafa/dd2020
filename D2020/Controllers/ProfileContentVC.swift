//
//  ProfileContentVC.swift
//  D2020
//
//  Created by Macbook on 2/22/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class ProfileContentVC: UIViewController {
    
    var PageIndex = 0
      var ImageName : String?
    
    @IBOutlet weak var promoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentImage = ImageName {
                   promoImageView.image = UIImage(named: currentImage)
               }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
