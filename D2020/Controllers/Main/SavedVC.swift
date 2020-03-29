//
//  SavedVC.swift
//  D2020
//
//  Created by Macbook on 3/4/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit




class SavedVC: BaseController {
    
    

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var family: UIView!
    @IBOutlet weak var rent: UIView!
    @IBOutlet weak var shops: UIView!
    
    
    override func viewDidLoad() {
        super.hiddenNav = true
        super.viewDidLoad()
        titleLbl.text = "wishlist.lan".localized
    }
    @IBAction func showComments(_ sender: Any) {
        

              if ((sender as AnyObject).selectedSegmentIndex == 0 ) {
                        UIView.animate(withDuration: 0.5, animations: {
                          self.family.alpha = 1
                          self.rent.alpha = 0
                            self.shops.alpha = 0
                            
                        }
                        )
                    }
              
              else if ((sender as AnyObject).selectedSegmentIndex == 1 ) {
                         UIView.animate(withDuration: 0.5, animations: {
                          self.rent.alpha = 1
                             self.shops.alpha = 0
                             
                             self.family.alpha = 0
                             
                            
                         })
                     }
              
              
              else  {
                         UIView.animate(withDuration: 0.5, animations: {
                             self.shops.alpha = 1
                             self.family.alpha = 0
                             
                          self.rent.alpha = 0
                             
                            
                         })
        }
        
     
    }
    
    

}
