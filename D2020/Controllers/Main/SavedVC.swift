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
    
    var wishlist: WishlistModel?
    var currentTab: Tabs = .stores
    override func viewDidLoad() {
        super.hiddenNav = true
        super.viewDidLoad()
        titleLbl.text = "wishlist.lan".localized
        setup()
        localize()
        handlers()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchWishlist()
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
    func fetchWishlist() {
        ApiManager.instance.connection(.wishlist, type: .get) { (response) in
            let data = try? JSONDecoder().decode(WishlistModel.self, from: response ?? Data())
            self.wishlist = data
            self.wishlistTbl.reloadData()
        }
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
            return wishlist?.shops?.count ?? 0
        case .rent:
            return wishlist?.forRent?.count ?? 0
        case .family:
            return wishlist?.houseAds?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:Identifiers.AfterSelectingCell, for: indexPath) as! AfterSelectingCell
        switch currentTab {
        case .stores:
            cell.setStyle = .orange
            cell.imageSelected.setImage(url: wishlist?.shops?[indexPath.row].image)
            cell.titleSelected.text = wishlist?.shops?[indexPath.row].name
            cell.kmSelected.text = wishlist?.shops?[indexPath.row].distance
            cell.ratingView.rating = Double(wishlist?.shops?[indexPath.row].rate ?? 0)
            cell.categoryBtn.setTitle(wishlist?.shops?[indexPath.row].catName, for: .normal)
        case .rent:
            cell.setStyle = .green
            cell.imageSelected.setImage(url: wishlist?.forRent?[indexPath.row].image)
            cell.titleSelected.text = wishlist?.forRent?[indexPath.row].name
            cell.kmSelected.text = wishlist?.forRent?[indexPath.row].distance
            cell.ratingView.rating = Double(wishlist?.forRent?[indexPath.row].rate ?? 0)
            cell.categoryBtn.setTitle("\(wishlist?.forRent?[indexPath.row].price ?? 0)", for: .normal)
        case .family:
            cell.setStyle = .red
            cell.imageSelected.setImage(url: wishlist?.houseAds?[indexPath.row].image)
            cell.titleSelected.text = wishlist?.houseAds?[indexPath.row].name
            cell.kmSelected.text = wishlist?.houseAds?[indexPath.row].distance
            cell.ratingView.rating = Double(wishlist?.houseAds?[indexPath.row].rate ?? 0)
            cell.categoryBtn.setTitle("\(wishlist?.houseAds?[indexPath.row].price ?? 0)", for: .normal)
        }
      
        cell.premiumLogo.isHidden = true
        cell.saveButton.setImage(UIImage(named: "save_act"), for: .normal)
        cell.saveButton.UIViewAction { [weak self] in
            self?.favorite(path: indexPath.row)
        }
        return cell
    }
    
}

extension SavedVC {
    func favorite(path: Int) {
        var method = ""
        if currentTab == .stores {
            method = api(.favorite, [self.wishlist?.shops?[path].id ?? 0])
            self.wishlist?.shops?.remove(at: path)
        } else if currentTab == .rent {
            method = api(.adsFavorite, [self.wishlist?.forRent?[path].id ?? 0])
            self.wishlist?.forRent?.remove(at: path)
        } else {
            method = api(.adsFavorite, [self.wishlist?.houseAds?[path].id ?? 0])
            self.wishlist?.houseAds?.remove(at: path)
        }
        self.wishlistTbl.reloadData()
        ApiManager.instance.connection(method, type: .post) { (response) in
            
        }
    }
}
