//
//  WalkThroughContentVC.swift
//  D2020
//
//  Created by Macbook on 2/26/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class WalkThroughContentVC: UIViewController {
    
    // Mark: - Outlets
    
    @IBOutlet var headingLabel: UILabel! {
        didSet {
        headingLabel.numberOfLines = 0
    }
}

@IBOutlet var subHeadingLabel: UILabel!{
    didSet{
    subHeadingLabel.numberOfLines = 0
    
}
}
    
    @IBOutlet var ContentImageView: UIImageView!
    
    // Mark: - Properties
    
    var index = 0
    var heading = ""
    var subHeading = ""
    var imageFile = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headingLabel.text = heading
        subHeadingLabel.text = subHeading
        ContentImageView.image = UIImage(named: imageFile)
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
