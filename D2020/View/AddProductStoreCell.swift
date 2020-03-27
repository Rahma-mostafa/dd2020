//
//  productsCollectionViewCell.swift
//  D2020
//
//  Created by MacBook Pro on 3/10/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class AddProductStoreCell: UICollectionViewCell, CellProtocol {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var editPencil: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    func setup() {
        guard let model = model as? AddProductModel else { return }
        image.image = model.image
        nameLbl.text = model.name
        priceLbl.text = model.price
        
    }
}

