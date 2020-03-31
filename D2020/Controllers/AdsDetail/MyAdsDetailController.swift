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

class MyAdsDetailController: BaseController {
    
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
    @IBOutlet weak var areaLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var frunitureLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var isPremImage: UIImageView!
    @IBOutlet weak var createReviewBtn: UIButton!
    @IBOutlet weak var speceficView: UIView!
    @IBOutlet weak var speceficViewHeight: NSLayoutConstraint!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var upgradeView: GradientView!
    @IBOutlet weak var upgradeLbl: UILabel!
    
    var ads: StoreDetail.StoreData?
    var adsID: Int?
    var scrollHeightValue: CGFloat = 870
    var isExpandable: Bool?
    var style: Style = .green
    var section: Int?
    override func viewDidLoad() {
        super.hiddenNav = true
        super.viewDidLoad()
        setupStyle()
        setup()
        setupLocalize()
        handlers()
        fetchAd()
    }
    func setupStyle() {
        if style == .red {
            editBtn.backgroundColor = .appRed
            categoryBtn.backgroundColor = .appRed
            createReviewBtn.backgroundColor = .appRed
            commentTxf.underlineActive = .appRed
            priceLbl.textColor = .appRed
            storeRate.settings.filledImage = #imageLiteral(resourceName: "star (5)")
            rateComment.settings.filledImage = #imageLiteral(resourceName: "star (5)")
                
            speceficView.isHidden = true
            speceficViewHeight.constant = 0
            scrollHeightValue -= 150
        }
    }
    func setup() {
        navView.isHidden = true
        navHieght.constant = 0
        scrollView.delegate = self
        collectionSlider.delegate = self
        collectionSlider.dataSource = self
        commentTbl.delegate = self
        commentTbl.dataSource = self
    }
    
    func fetchAd() {
        let method = api(.getSingleAd, [adsID ?? 0])
        startLoading()
        ApiManager.instance.connection(method, type: .get) { [weak self] (response) in
            self?.stopLoading()
            let data = try? JSONDecoder().decode(StoreDetail.self, from: response ?? Data())
            self?.ads = data?.data
            self?.setupUI()
            self?.setupHeights()
        }
    }
    func setupUI() {
        let user =  UserRoot.fetch()
        storeNavImage.setImage(url: ads?.image)
        storeNavLbl.text = ads?.name
        storeImage.setImage(url: ads?.image)
        storeLbl.text = ads?.name
        categoryBtn.setTitle(ads?.cat_name, for: .normal)
        distanceLbl.text = ads?.distance
        descLbl.text = ads?.desc
        userImage.setImage(url: user?.user?.image)
        usernameLbl.text = user?.user?.name
        storeRate.rating = Double(ads?.rate ?? 0)
        countRateLbl.text = "\(ads?.user_comment?.count ?? 0) \(Localizations.personRate.localized)"
        collectionSlider.reloadData()
        setupFavorite()
        
        priceLbl.text = "\(ads?.price ?? 0) \(CountryViewController.deviceCountry?.currency ?? "")"
        areaLbl.text = ""
        typeLbl.text = ""
        frunitureLbl.text = ""
        isPremImage.isHidden = true
            
//        if ads?.type == 1 {
//            isPremImage.isHidden = false
//        } else {
//            isPremImage.isHidden = true
//        }
    }
    func setupFavorite(change: Bool? = nil) {
        if case change = true {
            if case ads?.is_favorite = true  {
                ads?.is_favorite = false
            } else {
                ads?.is_favorite = true
            }
        }
        if case ads?.is_favorite = true {
            saveBtn.setImage(UIImage(named: "save_act"), for: .normal)
        } else {
            saveBtn.setImage(UIImage(named: "save"), for: .normal)
        }
    }
    func setupLocalize() {
        productsLbl.text = Localizations.specfications.localized
        rateLbl.text = Localizations.comments.localized
        countRateLbl.text = Localizations.personRate.localized
        yourRateLbl.text = Localizations.yourRate.localized
        allRateLbl.text = Localizations.allRate.localized
        commentTxf.placeholder = Localizations.yourRate.localized
        editBtn.setTitle("edit.lan".localized, for: .normal)
        upgradeLbl.text = "upgrade.account.lan".localized
    }
    func setupHeights(scrollPoint: CGPoint? = nil) {
        let commentCount = CGFloat((ads?.user_comment?.count ?? 0))
        scrollHeight.constant = scrollHeightValue
        scrollHeight.constant += commentCount * 151
        commentsHeight.constant = 0
        commentsHeight.constant += commentCount * 151
        commentTbl.reloadData()
        
        /** check user loging */
        yourRateLbl.isHidden = true
        yourRatView.isHidden = true
        yourRateHeight.constant = 0
        scrollHeight.constant -= 151
        
        
    }
    func createComment() {
        var model = StoreDetail.Comment()
        model.name = UserRoot.fetch()?.user?.name
        model.image = UserRoot.fetch()?.user?.image
        model.rate = String(rateComment.rating)
        model.comment = commentTxf.text
        ads?.user_comment?.insert(model, at: 0)
        setupHeights()
    }
    func handlers() {
        storeImage.UIViewAction {
            self.displayImage(image: self.ads?.image)
        }
        saveBtn.UIViewAction { [weak self] in
            let method = api(.adsFavorite, [self?.ads?.id ?? 0])
            ApiManager.instance.connection(method, type: .post) { [weak self] (response) in
                self?.setupFavorite(change: true)
            }
        }
        editBtn.UIViewAction {
            let vc = self.controller(AddAdDetailController.self, storyboard: .createAd)
            vc.editMode = true
            vc.ad = self.ads
            vc.section = self.section
            self.push(vc)
        }
        upgradeView.UIViewAction {
            let vc = self.controller(ForRentAdsVC.self, storyboard: .forRent)
            vc.delegate = self
            vc.adsID = self.ads?.id
            self.present(vc, animated: true, completion: nil)
        }
    }
  
    @IBAction func qrCode(_ sender: Any) {
        let vc = controller(QRCodeVC.self, storyboard: .store)
        pushPop(vcr: vc)
    }
    @IBAction func share(_ sender: Any) {
        shareApp(items: [ads?.name ?? "", ads?.desc ?? "", storeImage.image ?? UIImage()])
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
        let method = api(.adsRate, [ads?.id ?? 0])
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


extension MyAdsDetailController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        setupHeights()
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width, height: collectionView.height)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = ads?.images?.count ?? 0
        return ads?.images?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.cell(type: StoreSliderImageCell.self, indexPath, register: false)
        cell.model = ads?.images?[indexPath.row].image
        cell.image.UIViewAction { [weak self] in
            self?.displayImage(image: self?.ads?.images?[indexPath.row].image)
        }
        return cell
    }
}

extension MyAdsDetailController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 151
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ads?.user_comment?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: StoreCommentCell.self, indexPath, register: false)
        if style == .red {
            cell.rate.settings.filledImage = #imageLiteral(resourceName: "star (5)")
        }
        cell.model = ads?.user_comment?[indexPath.row]
        return cell
    }
    
    
}

extension MyAdsDetailController: ImageDisplayInterface, PackageDelegate, PaymentStoreDelegate {
    func didSelectPackage(package: Int) {
        let vc = controller(PaymentMethodVC.self, storyboard: .Upgrade)
        vc.delegate = self
        vc.packageID = package
        vc.adsID = self.adsID
        push(vc)
    }
    func didPaid() {
        upgradeView.isHidden = true
    }
}
