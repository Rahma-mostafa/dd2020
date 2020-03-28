//
//  SecondVC.swift
//  D2020
//
//  Created by Macbook on 3/15/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class SecondVC: UIViewController {

    @IBOutlet weak var nextBtnOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        nextBtnOutlet.layer.cornerRadius = 16
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
