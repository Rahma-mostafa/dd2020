//
//  PromoContentVCC.swift
//  D2020
//
//  Created by Macbook on 3/11/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class PromoContentVCC: UIViewController {
    @IBOutlet weak var promoImageView: UIImageView!
    var PaaageIndex = 0
       var ImmmageName : String?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let currentImage = ImmmageName {
                                 promoImageView.image = UIImage(named: currentImage)
                             }    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
