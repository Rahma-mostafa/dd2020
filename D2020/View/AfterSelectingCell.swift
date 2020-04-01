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

protocol StoreCellDelegate: class {
    func didSetFavorite(path: Int)
}
class AfterSelectingCell: UITableViewCell, CellProtocol {

    @IBOutlet weak var premiumLogo: UIImageView!
    @IBOutlet weak var roundedVew: UIView!
    @IBOutlet weak var imageSelected: UIImageView!
    @IBOutlet weak var titleSelected: UILabel!
    @IBOutlet weak var kmSelected: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var categoryBtn: UIButton!
    
    weak var delegate: StoreCellDelegate?
    var shop: MyStores.Datum?
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
        
        setupFavorite(change: false)
        saveButton.UIViewAction { [weak self] in
            self?.delegate?.didSetFavorite(path: self?.indexPath() ?? 0)
            self?.setupFavorite(change: true)
        }
    }
    func setupFavorite(change: Bool) {
        if case change = true {
            if case shop?.isFavorite = true  {
                shop?.isFavorite = false
            } else {
                shop?.isFavorite = true
            }
        }
        if case shop?.isFavorite = true  {
            saveButton.setImage(UIImage(named: "save_act"), for: .normal)
        } else {
            saveButton.setImage(UIImage(named: "save"), for: .normal)
        }
    }
}
