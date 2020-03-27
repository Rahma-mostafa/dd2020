//
//  productsCollectionViewCell.swift
//  D2020
//
//  Created by MacBook Pro on 3/10/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class StoreWorkdayCell: UICollectionViewCell, CellProtocol {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var viewColored: UIView!
    @IBOutlet weak var dayLbl: UILabel!
    
    func setup() {
        guard let model = model as? String else { return }
        viewColored.backgroundColor = .appRed
        image.image = UIImage(named: "close")
        dayLbl.text = model
        
    }
}

