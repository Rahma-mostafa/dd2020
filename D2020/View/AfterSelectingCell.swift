//
//  AfterSelectingCell.swift
//  D2020
//
//  Created by Macbook on 2/20/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import Cosmos
import TinyConstraints

class AfterSelectingCell: UITableViewCell, CellProtocol {

    @IBOutlet weak var premiumLogo: UIImageView!
    @IBOutlet weak var roundedVew: UIView!
    @IBOutlet weak var imageSelected: UIImageView!
    @IBOutlet weak var titleSelected: UILabel!
    @IBOutlet weak var kmSelected: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var categoryBtn: UIButton!
    
    var style: Style = .orange
  
    var setStyle: Style {
        get {
            return style
        } set {
            switch newValue {
            case .orange:
                categoryBtn.backgroundColor = .orangeFade
                categoryBtn.setTitleColor(.appOrange, for: .normal)
                ratingView.settings.filledImage = UIImage(named: "star (3)")
            case .green:
                categoryBtn.backgroundColor = .clear
                categoryBtn.setTitleColor(.appGreen, for: .normal)
                ratingView.settings.filledImage = UIImage(named: "star (4)")
            case .red:
                categoryBtn.backgroundColor = .clear
                categoryBtn.setTitleColor(.appRed, for: .normal)
                ratingView.settings.filledImage = UIImage(named: "star (5)")
            }
        }
        
    }
    func setup() {
        
    }
}
