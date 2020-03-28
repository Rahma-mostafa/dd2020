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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.title = categoryName
        setup()
        fetchShopsByCatID()
        
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
        if didSelectedItems[indexPath.row].type == 1 {
            let vc = controller(StorePremuimController.self, storyboard: .store)
            vc.storeID = didSelectedItems[indexPath.row].id
            push(vc)
        } else {
            let vc = controller(StoreDetailController.self, storyboard: .store)
            vc.storeID = didSelectedItems[indexPath.row].id
            push(vc)
        }
    }
    
    @objc func buttonClicked(sender:UIButton){
        let method = api(.favorite, [self.didSelectedItems[sender.tag].id!])
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
            (Name) in
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













