//
//  WalkthroughVC.swift
//  D2020
//
//  Created by Macbook on 2/26/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class WalkthroughVC: UIViewController {
    
    //Mark: - Outlets
    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet var nextButton:UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 25.0
            nextButton.layer.masksToBounds = true
        }
    }

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: Any) {
    }
    

}
