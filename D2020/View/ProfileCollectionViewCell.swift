//
//  ProfileCollectionViewCell.swift
//  D2020
//
//  Created by Macbook on 2/22/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class StoreProductCollectionCell: UICollectionViewCell, CellProtocol {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!

    func setup() {
        guard let model = model as? StoreDetail.Facilite else { return }
        image.setImage(url: model.image)
        productTitle.text = model.name
        productPrice.text = "\(model.price ?? 0) \(Localizations.sar.localized)"
    }
}



