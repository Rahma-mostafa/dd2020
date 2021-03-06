//
//  SelectedCategoryVC.swift
//  D2020
//
//  Created by Macbook on 2/22/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
struct  ItemdidSelected {
    var didSelectedName:String?
    var didSelecedImageName:String?
    var didSelectedKm:String?
}
class SelectedCategoryVC: BaseController {
    @IBOutlet weak var titleLabel: UIBarButtonItem!
    @IBOutlet weak var allShopsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var changeCityHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cityTextField: UITextField!
    
    var category:Int?
    var categoryName:String?
    var didSelectedItems:[ShopsByCatID.Datum] = []
    var style: Style = .orange
    var adsType: AdsType = .ad
    var locationHelper: LocationHelper?
    var runFilter: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.title = categoryName
        allShopsLabel.text = "all.lan".localized
        setupStyle()
        setup()
        
        if style == .orange {
            fetchShopsByCatID()
        } else {
            fetchAds()
        }
        
    }
    func setupStyle() {
        switch style {
        case .orange:
            self.navigationController?.navigationBar.barTintColor = .appOrange
            self.view.backgroundColor = .appOrange
            
        case .green:
            self.navigationController?.navigationBar.barTintColor = .appGreen
            self.view.backgroundColor = .appGreen
            adsType = .ad
        case .red:
            self.navigationController?.navigationBar.barTintColor = .appRed
            self.view.backgroundColor = .appRed
            adsType = .product
        }
    }
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    func fetchShopsByCatID() {
        startLoading()
        let method = api(.shop , [category ?? 0] )
        ApiManager.instance.headers["cat_id"] = "\(category ?? 0)"
        ApiManager.instance.connection(method, type: .get) { [weak self] (response) in
            self?.stopLoading()
            print("run")
            let data = try? JSONDecoder().decode(ShopsByCatID.self, from: response ?? Data())
            self?.didSelectedItems.append(contentsOf: data?.data ?? [])
            self?.tableView.reloadData()
            print("subCategory")
        }
    }
    
    func fetchAds() {
        startLoading()
        let method = api(.getAds , [category ?? 0] )
        ApiManager.instance.paramaters["type"] = adsType.rawValue
        ApiManager.instance.connection(method, type: .get) { [weak self] (response) in
            self?.stopLoading()
            print("run")
            let data = try? JSONDecoder().decode(ShopsByCatID.self, from: response ?? Data())
            self?.didSelectedItems.append(contentsOf: data?.data ?? [])
            self?.tableView.reloadData()
            print("subCategory")
        }
    }
    @IBAction func onOptionButtonTapped(_ sender: Any) {
        showTable()
    }
    
    @IBAction func onChooseButtonTapped(_ sender: Any) {
        showCityTable()
    }
    
}

extension SelectedCategoryVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return didSelectedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(type: AfterSelectingCell.self, indexPath, register: false)
        switch style {
        case .orange:
            cell.setStyle = .orange
        case .green:
            cell.setStyle = .green
        case .red:
            cell.setStyle = .red
        }
        cell.imageSelected.setImage(url: didSelectedItems[indexPath.row].image)
        cell.titleSelected.text = didSelectedItems[indexPath.row].name
        cell.kmSelected.text = didSelectedItems[indexPath.row].distance
        cell.ratingView.rating = didSelectedItems[indexPath.row].rate ?? 0
        cell.saveButton.tag = indexPath.row
        self.setupFavorite(change: false, sender: cell.saveButton)
        cell.saveButton.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        if didSelectedItems[indexPath.row].type == 1 {
            cell.premiumLogo.isHidden = false
        } else {
            cell.premiumLogo.isHidden = true
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if style == .orange {
            if didSelectedItems[indexPath.row].type == 1 {
                let vc = controller(StorePremuimController.self, storyboard: .store)
                vc.storeID = didSelectedItems[indexPath.row].id
                push(vc)
            } else {
                let vc = controller(StoreDetailController.self, storyboard: .store)
                vc.storeID = didSelectedItems[indexPath.row].id
                push(vc)
            }
        } else {
            let vc = controller(AdsDetailController.self, storyboard: .ads)
            vc.style = style
            vc.adsID = didSelectedItems[indexPath.row].id
            push(vc)
        }
        
    }
    
    @objc func buttonClicked(sender:UIButton){
        var method = ""
        if style == .orange {
            method = api(.favorite, [self.didSelectedItems[sender.tag].id!])
        } else {
            method = api(.adsFavorite, [self.didSelectedItems[sender.tag].id!])
        }
        ApiManager.instance.connection(method, type: .post) { [weak self] (response) in
            self?.setupFavorite(change: true ,sender: sender)
        }
    }
    func setupFavorite(change: Bool ,sender: UIButton ) {
        if case change = true {
            if case self.didSelectedItems[sender.tag].isFavorite = true  {
                self.didSelectedItems[sender.tag].isFavorite = false
            } else {
                self.didSelectedItems[sender.tag].isFavorite = true
            }
        }
        if case self.didSelectedItems[sender.tag].isFavorite = true  {
            sender.setImage(UIImage(named: "save_act"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "save"), for: .normal)
        }
    }
  
    private func showTable(){
        let vc = controller(OptionViewController.self, storyboard: .pop)
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

extension SelectedCategoryVC {
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
        let method = api(.filterShop , [category ?? 0] )
        ApiManager.instance.headers["cat_id"] = "\(category ?? 0)"
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
                let data = try JSONDecoder().decode(ShopsByCatID.self, from: response ?? Data())
                self?.didSelectedItems.removeAll()
                self?.didSelectedItems.append(contentsOf: data.data ?? [])
                self?.tableView.reloadData()
                print("subCategory")
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
}
