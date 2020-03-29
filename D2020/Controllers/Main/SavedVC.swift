//
//  SavedVC.swift
//  D2020
//
//  Created by Macbook on 3/4/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit




class SavedVC: BaseController {
    enum Tabs {
        case stores
        case rent
        case family
    }
    

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var storesBtn: UIButton!
    @IBOutlet weak var rentBtn: UIButton!
    @IBOutlet weak var familyBtn: UIButton!
    @IBOutlet weak var wishlistTbl: UITableView!
    
    var currentTab: Tabs = .stores
    override func viewDidLoad() {
        super.hiddenNav = true
        super.viewDidLoad()
        titleLbl.text = "wishlist.lan".localized
        setup()
        localize()
        handlers()
    }
    
    func setup() {
        self.storesBtn.backgroundColor = .appOrange
        self.storesBtn.setTitleColor(.white, for: .normal)
        wishlistTbl.delegate = self
        wishlistTbl.dataSource = self
    }
    func localize() {
        storesBtn.setTitle(Localizations.stores.localized, for: .normal)
        rentBtn.setTitle(Localizations.rent.localized, for: .normal)
        familyBtn.setTitle(Localizations.family.localized, for: .normal)
        
    }
    func handlers() {
        storesBtn.UIViewAction {
            self.currentTab = .stores
            self.wishlistTbl.reloadData()
            self.storesBtn.backgroundColor = .appOrange
            self.storesBtn.setTitleColor(.white, for: .normal)
            
            self.rentBtn.backgroundColor = .groupTableViewBackground
            self.rentBtn.setTitleColor(.textColor, for: .normal)
            self.familyBtn.backgroundColor = .groupTableViewBackground
            self.familyBtn.setTitleColor(.textColor, for: .normal)
            
        }
        rentBtn.UIViewAction {
            self.currentTab = .rent
            self.wishlistTbl.reloadData()
            self.rentBtn.backgroundColor = .appGreen
            self.rentBtn.setTitleColor(.white, for: .normal)
            
            self.storesBtn.backgroundColor = .groupTableViewBackground
            self.storesBtn.setTitleColor(.textColor, for: .normal)
            self.familyBtn.backgroundColor = .groupTableViewBackground
            self.familyBtn.setTitleColor(.textColor, for: .normal)
            
        }
        familyBtn.UIViewAction {
            self.currentTab = .family
            self.wishlistTbl.reloadData()
            self.familyBtn.backgroundColor = .appRed
            self.familyBtn.setTitleColor(.white, for: .normal)
            
            self.rentBtn.backgroundColor = .groupTableViewBackground
            self.rentBtn.setTitleColor(.textColor, for: .normal)
            self.storesBtn.backgroundColor = .groupTableViewBackground
            self.storesBtn.setTitleColor(.textColor, for: .normal)
            
        }
    }
}
extension SavedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentTab {
        case .stores:
            return 10
        case .rent:
            return 10
        case .family:
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:Identifiers.AfterSelectingCell, for: indexPath) as! AfterSelectingCell
        switch currentTab {
        case .stores:
            cell.setStyle = .orange
        case .rent:
            cell.setStyle = .green
        case .family:
            cell.setStyle = .red
        }
        cell.imageSelected.image = #imageLiteral(resourceName: "jonathan-borba-u7fi6JmYbX8-unsplash")
        cell.titleSelected.text = "store"
        cell.kmSelected.text = "10 km"
        cell.ratingView.rating = 5
        cell.premiumLogo.isHidden = true
        cell.saveButton.setImage(UIImage(named: "save_act"), for: .normal)
        return cell
    }
    
}
