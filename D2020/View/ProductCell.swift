//
//  ProductCell.swift
//  D2020
//
//  Created by Macbook on 2/22/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categoryDesc: UILabel!
    @IBOutlet weak var roundedView: UIView!
    
    //Outlets : MyShops TableViewCell
    
    @IBOutlet weak var categoryImgB: UIImageView!
    @IBOutlet weak var categoryTitleB: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        roundedView.layer.cornerRadius = 20
        
    }
//    override func layoutSubviews() {
//           super.layoutSubviews()
//           let padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
//           bounds = bounds.inset(by: padding)
//    }
////
//   override func layoutSubviews() {
//        super.layoutSubviews()
//        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
//    bounds = bounds.inset(by: padding)
//    }

    override var frame: CGRect {
           get {
               return super.frame
           }
           set (newFrame) {
               var frame =  newFrame
               frame.origin.y += 4
               frame.size.height -= 2 * 4
               super.frame = frame
           }
    
}
}

