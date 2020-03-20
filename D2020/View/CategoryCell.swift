//
//  CategoryCell.swift
//  D2020
//
//  Created by Macbook on 2/19/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var categoryDesc: UILabel!
    @IBOutlet weak var coloredView: UIView!
    @IBOutlet weak var imageIcon: UIImageView!
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var roundedViewB: UIView!
    @IBOutlet weak var categoryImage2: UIImageView!
    @IBOutlet weak var coloredView2: UIView!
    @IBOutlet weak var imageIcon2: UIImageView!
    
    @IBOutlet weak var categoryLbl2: UILabel!
    @IBOutlet weak var categoryDesc2: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        coloredView.layer.cornerRadius = 15
//        categoryImage.layer.cornerRadius = 15
//        roundedView.layer.cornerRadius = 15
        
//        coloredView2.layer.cornerRadius = 15
//        categoryImage2.layer.cornerRadius = 15
//        roundedViewB.layer.cornerRadius = 15
        // Initialization code
    }
    
   
    }
//    func configureCell(category:Category){
//    categoryLbl.text = category.name
//        categoryDesc.text = category.description
//    if let url = URL(string: category.imgUrl) {
//        categoryImage.kf.setImage(with: url)
//    }
//}

