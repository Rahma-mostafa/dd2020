//
//  ProfileVC.swift
//  D2020
//
//  Created by Macbook on 2/22/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import MapKit
import Cosmos
import ContactsUI

class MyStoreDetailController: BaseController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var storeNavImage: UIImageView!
    @IBOutlet weak var storeNavLbl: UILabel!
    @IBOutlet weak var viewSlider: UIView!
    @IBOutlet weak var viewSliderHieght: NSLayoutConstraint!
    @IBOutlet weak var navHieght: NSLayoutConstraint!
    @IBOutlet weak var collectionSlider: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var storeImageView: RoundedShadowView!
    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var scrollHeight: NSLayoutConstraint!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoHeight: NSLayoutConstraint!
    @IBOutlet weak var storeLbl: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var categoryBtn: RoundedButton!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var productsLbl: UILabel!
    @IBOutlet weak var productsCollection: UICollectionView!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var storeRate: CosmosView!
    @IBOutlet weak var countRateLbl: UILabel!
    @IBOutlet weak var yourRateLbl: UILabel!
    @IBOutlet weak var allRateLbl: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var rateComment: CosmosView!
    @IBOutlet weak var commentTxf: UITextField!
    @IBOutlet weak var commentTbl: UITableView!
    @IBOutlet weak var commentsHeight: NSLayoutConstraint!
    //@IBOutlet weak var scrollViewTop: NSLayoutConstraint!
    @IBOutlet weak var containerViewTop: NSLayoutConstraint!
    @IBOutlet weak var yourRateHeight: NSLayoutConstraint!
    @IBOutlet weak var yourRatView: UIView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var upgradeView: GradientView!
    @IBOutlet weak var upgradeLbl: UILabel!

    
    var store: StoreDetail.StoreData?
    var storeID: Int?
    var scrollHeightValue: CGFloat = 950
    var isExpandable: Bool?
    override func viewDidLoad() {
        super.hiddenNav = true
        super.viewDidLoad()
        setup()
        setupLocalize()
        handlers()
        fetchStore()
    }
    
    func setup() {
        navView.isHidden = true
        navHieght.constant = 0
        scrollView.delegate = self
        collectionSlider.delegate = self
        collectionSlider.dataSource = self
        productsCollection.delegate = self
        productsCollection.dataSource = self
        commentTbl.delegate = self
        commentTbl.dataSource = self
    }
    
    func fetchStore() {
        let method = api(.getSingleShop, [storeID ?? 0])
        startLoading()
        ApiManager.instance.connection(method, type: .get) { [weak self] (response) in
            self?.stopLoading()
            let data = try? JSONDecoder().decode(StoreDetail.self, from: response ?? Data())
            self?.store = data?.data
            self?.setupUI()
            self?.setupHeights()
        }
    }
    func setupUI() {
        let user =  UserRoot.fetch()
        storeNavImage.setImage(url: store?.image)
        storeNavLbl.text = store?.name
        storeImage.setImage(url: store?.image)
        storeLbl.text = store?.name
        categoryBtn.setTitle(store?.cat_name, for: .normal)
        distanceLbl.text = store?.distance
        descLbl.text = store?.desc
        userImage.setImage(url: user?.user?.image)
        usernameLbl.text = user?.user?.name
        storeRate.rating = Double(store?.rate ?? 0)
        countRateLbl.text = "\(store?.user_comment?.count ?? 0) \(Localizations.personRate.localized)"
        collectionSlider.reloadData()
        productsCollection.reloadData()
        setupFavorite()
    }
    func setupFavorite(change: Bool? = nil) {
        if case change = true {
            if case store?.is_favorite = true  {
                store?.is_favorite = false
            } else {
                store?.is_favorite = true
            }
        }
        if case store?.is_favorite = true {
            saveBtn.setImage(UIImage(named: "save_act"), for: .normal)
        } else {
            saveBtn.setImage(UIImage(named: "save"), for: .normal)
        }
    }
    func setupLocalize() {
        productsLbl.text = Localizations.products.localized
        rateLbl.text = Localizations.comments.localized
        countRateLbl.text = Localizations.personRate.localized
        yourRateLbl.text = Localizations.yourRate.localized
        allRateLbl.text = Localizations.allRate.localized
        commentTxf.placeholder = Localizations.yourRate.localized
        editBtn.setTitle("edit.lan".localized, for: .normal)
        upgradeLbl.text = "upgrade.account.lan".localized
        
    }
    func setupHeights(scrollPoint: CGPoint? = nil) {
        let commentCount = CGFloat((store?.user_comment?.count ?? 0))
        scrollHeight.constant = scrollHeightValue
        scrollHeight.constant += commentCount * 152
        commentsHeight.constant = 0
        commentsHeight.constant += commentCount * 152
        commentTbl.reloadData()
        
        /** check user loging */
        if UserRoot.token() == nil {
            yourRateLbl.isHidden = true
            yourRatView.isHidden = true
            yourRateHeight.constant = 0
            scrollHeight.constant -= 151
        }
        
        if self.scrollView.contentOffset.y > 90 {
            self.viewSlider.fadeOut(duration: 0.5, completion: nil)
            self.infoView.fadeOut(duration: 0.5, completion: nil)
            self.navView.fadeIn(duration: 0.5, completion: nil)
            
            //self.navView.isHidden = false
            self.navHieght.constant = 90
            //self.viewSlider.isHidden = true
            self.viewSliderHieght.constant = 0
            //self.infoView.isHidden = true
            self.infoHeight.constant = 0
            self.storeImageView.isHidden = true
            self.scrollHeight.constant -= 290
            
            self.containerViewTop.constant = 170
            
            isExpandable = true

        } else {
            self.viewSlider.fadeIn(duration: 0.5, completion: nil)
            self.infoView.fadeIn(duration: 0.5, completion: nil)
            self.navView.fadeOut(duration: 0.5, completion: nil)
            
            //self.navView.isHidden = true
            self.navHieght.constant = 0
            //self.viewSlider.isHidden = false
            self.viewSliderHieght.constant = 256
            //self.infoView.isHidden = false
            self.infoHeight.constant = 290
            self.storeImageView.isHidden = false
            self.scrollHeight.constant += 290
            
            self.containerViewTop.constant = 8
            
            
            isExpandable = false

        }
       // guard let scrollPoint = scrollPoint else { return }

        
    }
    func createComment() {
        var model = StoreDetail.Comment()
        model.name = ""
        model.image = ""
        model.rate = String(rateComment.rating)
        model.comment = commentTxf.text
        store?.user_comment?.insert(model, at: 0)
        setupHeights()
    }
    func handlers() {
        storeImage.UIViewAction {
            self.displayImage(image: self.store?.image)
        }
        saveBtn.UIViewAction { [weak self] in
            let method = api(.favorite, [self?.store?.id ?? 0])
            ApiManager.instance.connection(method, type: .post) { [weak self] (response) in
                self?.setupFavorite(change: true)
            }
        }
        upgradeView.UIViewAction {
            let vc = self.controller(PackageVC.self, storyboard: .Upgrade)
            self.push(vc)
        }
    }
    @IBAction func search(_ sender: Any) {
    }
    @IBAction func chat(_ sender: Any) {
    }
    @IBAction func qrCode(_ sender: Any) {
        let vc = controller(QRCodeVC.self, storyboard: .store)
        pushPop(vcr: vc)
    }
    @IBAction func share(_ sender: Any) {
        shareApp(items: [store?.name ?? "", store?.desc ?? "", storeImage.image ?? UIImage()])
    }
    @IBAction func createReview(_ sender: Any) {
        if case commentTxf.text?.isEmpty = true {
            snackBar(message: "this_field_is_required.lan".localized, duration: .short)
            return
        }
        if rateComment.rating == 0 {
            snackBar(message: "this_field_is_required.lan".localized, duration: .short)
            return
        }
        startLoading()
        let method = api(.rate, [store?.id ?? 0])
        ApiManager.instance.paramaters["comment"] = commentTxf.text
        ApiManager.instance.paramaters["rate"] = rateComment.rating
        ApiManager.instance.connection(method, type: .post) { [weak self] (response) in
            self?.stopLoading()
            let data = try? JSONDecoder().decode(BaseModel.self, from: response ?? Data())
            self?.snackBar(message: data?.message ?? "", duration: .short)
            self?.createComment()
        }
    }
    
    
}


extension MyStoreDetailController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        setupHeights()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionSlider {
            return CGSize(width: collectionView.width, height: collectionView.height)
        } else {
            return CGSize(width: 112, height: 152)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionSlider {
            pageControl.numberOfPages = store?.images?.count ?? 0
            return store?.images?.count ?? 0
        } else {
            return store?.products?.count ?? 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionSlider {
            var cell = collectionView.cell(type: StoreSliderImageCell.self, indexPath, register: false)
            cell.model = store?.images?[indexPath.row].image
            cell.image.UIViewAction { [weak self] in
                self?.displayImage(image: self?.store?.images?[indexPath.row].image)
            }
            return cell
        } else {
            var cell = collectionView.cell(type: StoreProductCollectionCell.self, indexPath, register: false)
            cell.model = store?.products?[indexPath.row]
            return cell
        }
    }
}

extension MyStoreDetailController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 151
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store?.user_comment?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: StoreCommentCell.self, indexPath, register: false)
        cell.model = store?.user_comment?[indexPath.row]
        return cell
    }
    
    
}

extension MyStoreDetailController: ImageDisplayInterface {
    
}
