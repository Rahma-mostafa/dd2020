//
//  productsCollectionViewCell.swift
//  D2020
//
//  Created by MacBook Pro on 3/10/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class StoreSliderImageCell: UICollectionViewCell, CellProtocol {

    @IBOutlet weak var image: UIImageView!
    
    func setup() {
        guard let model = model as? String else { return }
        image.setImage(url: model)
    }
}
