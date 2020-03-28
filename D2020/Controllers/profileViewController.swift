//
//  profileViewController.swift
//  d2020
//
//  Created by MacBook Pro on 3/16/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import UIKit

class profileViewController: UIViewController {
  
    @IBOutlet weak var maleButton: RoundedButton!
    
    @IBOutlet weak var femaleButton: RoundedButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        maleButton.layer.cornerRadius = 16
        femaleButton.layer.cornerRadius = 16
        
        
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
