//
//  EachCategoryVC.swift
//  D2020
//
//  Created by Macbook on 2/20/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

struct ItemSelected {
    var selectedname: String?
    var ImageSelectedName : String?
    var kmPassedSelected : String?
    var logoPremium:String?
    
}

struct ItemSubCategory {
    var name: String?
    var imageName : String?
}

class EachCategoryVC: BaseController {
    
    @IBOutlet weak var titleLabel: UIBarButtonItem!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var allSubCategoryLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var changeCityHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cityTextField: UITextField!
    
    var category : Item!
    var selectedCategory : String?
    var section:Int?
    var subCategoryArray:[SubCategoryAndShops.Category] = []
    var shopArray:[SubCategoryAndShops.Shop] = []
    var style: Style = .orange
    var locationHelper: LocationHelper?
    var runFilter: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.title = selectedCategory
        categoryLabel.text = "categories.f.lan".localized
        allSubCategoryLabel.text = "all.lan".localized
        setupStyle()
        setup()
        if style == .orange {
            fetchShops()
        } else {
            fetchAds()
        }
        collectionView.register(UINib(nibName: Identifiers.SubCategoryCell, bundle: nil), forCellWithReuseIdentifier: Identifiers.SubCategoryCell)
        
    }
    func setupStyle() {
        switch style {
        case .orange:
            self.navigationController?.navigationBar.barTintColor = .appOrange
            self.view.backgroundColor = .appOrange

        case .green:
            self.navigationController?.navigationBar.barTintColor = .appGreen
            self.view.backgroundColor = .appGreen
        case .red:
            self.navigationController?.navigationBar.barTintColor = .appRed
            self.view.backgroundColor = .appRed
        }
    }
    func setup(){
        tableView.delegate = self
        tableView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    func fetchShops() {
        startLoading()
        let method = api(.getSubCategoryAndShop , [section ?? 0] )
        ApiManager.instance.headers["section_id"] = "\(section ?? 0)"
        ApiManager.instance.connection(method, type: .get) { [weak self] (response) in
            self?.stopLoading()
            print("run")
            do {
                let data = try JSONDecoder().decode(SubCategoryAndShops.self, from: response ?? Data())
                self?.subCategoryArray.append(contentsOf: data.categories ?? [])
                self?.shopArray.append(contentsOf: data.shops ?? [])
                self?.tableView.reloadData()
                self?.collectionView.reloadData()
                print("subCategory")
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    func fetchAds() {
        startLoading()
        let method = api(.getSubCategoryAndAds , [section ?? 0] )
        ApiManager.instance.headers["section_id"] = "\(section ?? 0)"
        ApiManager.instance.connection(method, type: .get) { [weak self] (response) in
            self?.stopLoading()
            print("run")
            do {
                let data = try JSONDecoder().decode(SubCategoryAndShops.self, from: response ?? Data())
                self?.subCategoryArray.append(contentsOf: data.categories ?? [])
                self?.shopArray.append(contentsOf: data.ads ?? [])
                self?.tableView.reloadData()
                self?.collectionView.reloadData()
                print("subCategory")
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    @IBAction func onOptionButtonTapped(_ sender: Any) {
        showTable()
    }
    
    @IBAction func onChooseButtonClick(_ sender: Any) {
        showCityTable()
    }
    
    
}

extension EachCategoryVC : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource ,UITableViewDelegate,UITableViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subCategoryArray.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.SubCategoryCell, for: indexPath) as? SubCategoryCell
        
        cell?.subCategoryImg.setImage(url: subCategoryArray[indexPath.item].image)
        
        cell?.subCategoryTitle.text = subCategoryArray[indexPath.item].name
        
        
        return cell!
    }
    
    //(10) d lly btt7km f 7gm l cell lyy htt3rdly 7sb 7gm l telephone lly h3rd 3leh
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        let cellWidth = (width - 50) / 4
        let cellHeight = cellWidth * 1.5
        
        return CGSize(width: cellWidth, height: cellHeight)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Category", bundle: nil)
        let scene = storyboard.instantiateViewController(withIdentifier: "SelectedCategoryVC") as! SelectedCategoryVC
        scene.style = style
        scene.category = subCategoryArray[indexPath.row].id
        scene.categoryName = subCategoryArray[indexPath.row].name
        navigationController?.pushViewController(scene, animated: true)
        
        
    }
    
    // shopsTableView
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return shopArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:Identifiers.AfterSelectingCell , for: indexPath) as! AfterSelectingCell
        switch style {
        case .orange:
            cell.setStyle = .orange
        case .green:
            cell.setStyle = .green
        case .red:
            cell.setStyle = .red
        }
        cell.imageSelected.setImage(url: shopArray[indexPath.row].image!)
        cell.titleSelected.text = shopArray[indexPath.row].name
        cell.kmSelected.text = shopArray[indexPath.row].distance
        cell.ratingView.rating = Double(shopArray[indexPath.row].rate!)
        cell.saveButton.tag = indexPath.row
        self.setupFavorite(change: false, sender: cell.saveButton)
        cell.saveButton.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        if shopArray[indexPath.row].type == 1 {
            cell.premiumLogo.isHidden = false
        } else {
            cell.premiumLogo.isHidden = true
        }
        return cell
    }
    @objc func buttonClicked(sender:UIButton){
        var method = ""
        if style == .orange {
            method = api(.favorite, [self.shopArray[sender.tag].id!])
        } else {
            method = api(.adsFavorite, [self.shopArray[sender.tag].id!])
        }
        ApiManager.instance.connection(method, type: .post) { [weak self] (response) in
            self?.setupFavorite(change: true ,sender: sender)
        }
    }
    func setupFavorite(change: Bool ,sender: UIButton ) {
        if case change = true {
            if case self.shopArray[sender.tag].isFavorite = true  {
                self.shopArray[sender.tag].isFavorite = false
            } else {
                self.shopArray[sender.tag].isFavorite = true
            }
        }
        if case self.shopArray[sender.tag].isFavorite = true  {
            sender.setImage(UIImage(named: "save_act"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "save"), for: .normal)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if style == .orange {
            if shopArray[indexPath.row].type == 1 {
                let vc = controller(StorePremuimController.self, storyboard: .store)
                vc.storeID = shopArray[indexPath.row].id
                push(vc)
            } else {
                let vc = controller(StoreDetailController.self, storyboard: .store)
                vc.storeID = shopArray[indexPath.row].id
                push(vc)
            }
        } else {
            let vc = controller(AdsDetailController.self, storyboard: .ads)
            vc.style = style
            vc.adsID = shopArray[indexPath.row].id
            push(vc)
        }
        
        
    }
    private func showTable(){
        let vc = controller( OptionViewController.self, storyboard: .pop)
        vc.shouldHideTable = { [unowned self]
            (type) in
            if type == .nearest {
                self.getCurrentLocation()
            } else {
                self.filterShops(rate: 1)
            }
            self.hideTable()
        }
        self.pushPop(vcr: vc)
        
    }
    private func showCityTable(){
        let vc = controller(ChangeCityViewController.self, storyboard: .pop)
        vc.shouldHideTable = { [unowned self]
            (Name, id) in
            self.hideCityTable()
            self.cityTextField.text = Name
        }
        self.pushPop(vcr: vc)
    }
    
    func hideTable(){
        tableHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.5) {[unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    func hideCityTable(){
        changeCityHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.5) {[unowned self] in
            self.view.layoutIfNeeded()
        }
    }

    
}

extension EachCategoryVC {
    func getCurrentLocation() {
        locationHelper = LocationHelper()
        locationHelper?.useOnlyoneTime = true
        locationHelper?.onUpdateLocation = { degree in
            self.filterShops(lat: degree?.latitude, lng: degree?.longitude)
        }
        locationHelper?.currentLocation()
    }
    
    func filterShops(lat: Double? = nil, lng: Double? = nil, rate: Int? = nil) {
        if runFilter {
            return
        }
        runFilter = true
        startLoading()
        let method = api(.filterShop , [section ?? 0] )
        ApiManager.instance.headers["cat_id"] = "\(section ?? 0)"
        if(lat != nil && lng != nil) {
            ApiManager.instance.paramaters["lat"] = lat ?? 0
            ApiManager.instance.paramaters["lang"] = lng ?? 0
        }
        if rate != nil {
            ApiManager.instance.paramaters["rate"] = rate ?? 0
        }
        ApiManager.instance.connection(method, type: .post) { [weak self] (response) in
            self?.runFilter = false
            self?.stopLoading()
            print("run")
            do {
                let data = try JSONDecoder().decode(SubCategoryAndShops.self, from: response ?? Data())
                self?.shopArray.removeAll()
                self?.shopArray.append(contentsOf: data.data ?? [])
                self?.tableView.reloadData()
                print("subCategory")
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
}
