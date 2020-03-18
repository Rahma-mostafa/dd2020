//
//  RoundedViews.swift
//  D2020
//
//  Created by Macbook on 2/15/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
class RoundedButton : UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
    }
}
class RoundedTabBar: UITabBar{
   
       
        override func draw(_ rect: CGRect) {
            // Drawing code
            self.layer.cornerRadius = 10
            self.clipsToBounds = true
        }
        

    }


        
       


class RoundedShadowView : UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 15
//        layer.shadowColor = AppColors.Blue.cgColor
//        layer.shadowOpacity = 0.4
//        layer.shadowOffset = CGSize.zero
//        layer.shadowRadius = 3
    }
}

class RoundedImageView : UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 15
    }
}

