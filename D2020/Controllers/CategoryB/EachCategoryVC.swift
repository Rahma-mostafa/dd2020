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
    
    
    
    var category : Item!
    var selectedCategory : String?
    var section:Int?
    var subCategoryArray:[SubCategoryAndShops.Category] = []
    var shopArray:[SubCategoryAndShops.Shop] = []
    
    @IBOutlet weak var titleLabel: UIBarButtonItem!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var allSubCategoryLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var changeCityHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cityTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.title = selectedCategory
        setup()
        //fetchSubCategories()
        fetchShops()
        collectionView.register(UINib(nibName: Identifiers.SubCategoryCell, bundle: nil), forCellWithReuseIdentifier: Identifiers.SubCategoryCell)
        
    }
    func setup(){
        tableView.delegate = self
        tableView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        //localozation
        categoryLabel.text = "category.lan".localized
        allSubCategoryLabel.text = "all.lan".localized
        cityTextField.attributedPlaceholder = NSAttributedString(string: "select_city".localized)

        
        
    }
    func fetchSubCategories() {
        startLoading()
        let method = api(.getSubCategoryAndShop , [section ?? 0] )
        ApiManager.instance.headers["section_id"] = "\(section ?? 0)"
        ApiManager.instance.connection(method, type: .get) { [weak self] (response) in
            self?.stopLoading()
            print("run")
            let data = try? JSONDecoder().decode(SubCategoryAndShops.self, from: response ?? Data())
            self?.subCategoryArray.append(contentsOf: data?.categories ?? [])
            self?.collectionView.reloadData()
            print("subCategory")
        }
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
        let method = api(.favorite, [self.shopArray[sender.tag].id!])
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
        
        if shopArray[indexPath.row].type == 1 {
            let vc = controller(StorePremuimController.self, storyboard: .store)
            vc.storeID = shopArray[indexPath.row].id
            push(vc)
        } else {
            let vc = controller(StoreDetailController.self, storyboard: .store)
            vc.storeID = shopArray[indexPath.row].id
            push(vc)
        }
        
    }
    private func showTable(){
        let vc = controller( OptionViewController.self, storyboard: .pop)
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

