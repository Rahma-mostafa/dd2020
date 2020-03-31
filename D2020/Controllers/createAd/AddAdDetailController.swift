//
//  AddShopDetailsVC.swift
//  D2020
//
//  Created by Macbook on 3/9/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import GooglePlaces

class AddAdDetailController: BaseController {
    @IBOutlet weak var sliderCollection: UICollectionView!
    @IBOutlet weak var noPhotoImage: UIImageView!
    @IBOutlet weak var addImageLbl: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var storeLogoImage: UIImageView!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var storeNameTxf: UITextField!
    @IBOutlet weak var storeDescTxf: UITextField!
    @IBOutlet weak var priceTxf: UITextField!
    @IBOutlet weak var mobileTxf: UITextField!
    @IBOutlet weak var categoryTxf: UITextField!
    @IBOutlet weak var typeTxf: UITextField!
    @IBOutlet weak var cityTxf: UITextField!
    @IBOutlet weak var locationTxf: UITextField!
    @IBOutlet weak var nextBtn: RoundedButton!

    var style: Style = .green
    var section: Int?
    var type = 2
    var picker: GalleryPickerHelper?
    var mapHelper: GoogleMapHelper?
    var images: [UIImage] = []
    var logo: UIImage?
    var imagesURL: [URL] = []
    var logoURL: URL?
    var cities: [CityModel.CityData] = []
    var categories: [Category.DateElement] = []
    var subCategories: [SubCategoryModel.Data] = []
    var selectedCity: Int?
    var selectedCategory: Int?
    var selectedSubCategory: Int?
    var lat: Double?
    var lng: Double?
    var ad: StoreDetail.StoreData?
    var editMode: Bool = false
    var imagesViewEdited: [UIImageView] = []
    override func viewDidLoad() {
        super.hiddenNav = true
        super.viewDidLoad()
        setupStyle()
        setup()
        if editMode {
            setupEdit()
        }
        handlers()
    }
    func setupStyle() {
        if style == .red {
            self.navigationController?.navigationBar.barTintColor = .appRed
            self.type = 1
        }
    }
    func setup() {
        addImageLbl.text = "add.images.for.ads.lan".localized
        nextBtn.setTitle(Localizations.next.localized, for: .normal)
        picker = GalleryPickerHelper()
        mapHelper = .init()
        mapHelper?.placePickerDelegate = self
        
        sliderCollection.delegate = self
        sliderCollection.dataSource = self
        
        fetchCities()
    }
    func setupEdit() {
        noPhotoImage.isHidden = true
        addImageLbl.isHidden = true
        plusBtn.isHidden = true
        storeLogoImage.setImage(url: ad?.image)
        storeNameTxf.text = ad?.name
        storeDescTxf.text = ad?.desc
        mobileTxf.text = ad?.phone
        priceTxf.text = "\(ad?.price ?? 0)"
        
        ad?.images?.forEach({ (image) in
            let imageView = UIImageView()
            imageView.setImage(url: image.image)
            self.images.append(imageView.image ?? UIImage())
            self.imagesViewEdited.append(imageView)
        })
    }
    func handlers() {
        noPhotoImage.UIViewAction(selector: pickImage)
        sliderCollection.UIViewAction(selector: pickImage)
        plusBtn.UIViewAction(selector: pickLogo)
        storeLogoImage.UIViewAction(selector: pickLogo)
    
    }
    func pickImage() {
        self.picker?.onPickImage = { image in
            self.images.append(image)
            self.sliderCollection.reloadData()
            self.sliderCollection.scrollToItem(at: IndexPath(row: self.images.count - 1 , section: 0), at: .centeredHorizontally, animated: true)
            self.noPhotoImage.isHidden = true
        }
        self.picker?.onPickImageURL = { url in
            guard let url = url else { return }
            self.imagesURL.append(url)
        }
        self.picker?.pick(in: self, type: .picture)
    }
    func pickLogo() {
        self.picker?.onPickImage = { image in
            self.logo = image
            self.storeLogoImage.image = image
            self.plusBtn.isHidden = true
        }
        self.picker?.onPickImageURL = { url in
            guard let url = url else { return }
            self.logoURL = url
        }
        self.picker?.pick(in: self, type: .picture)
    }
    
    func fetchCities() {
        startLoading()
        let method = api(.SubCountry, [CountryViewController.deviceCountry?.id ?? 0])
        ApiManager.instance.connection(method, type: .get) { (response) in
            self.stopLoading()
            let data = try? JSONDecoder().decode(CityModel.self, from: response ?? Data())
            self.cities.append(contentsOf: data?.data ?? [])
        }
    }
    func fetchCategories() {
        let method = api(.getCategory, [section ?? 0])
//        ApiManager.instance.paramaters["city_id"] = self.cities[selectedCity ?? 0].id ?? 0
        ApiManager.instance.connection(method, type: .get) { (response) in
            let data = try? JSONDecoder().decode(Category.self, from: response ?? Data())
            self.categories.removeAll()
            self.categories.append(contentsOf: data?.date ?? [])
            self.pickCategory()
        }
    }
    func fetchSubCategory() {
        guard let selectedCategory = selectedCategory else { return }
        let method = api(.getSubCategoryAndShop, [categories[selectedCategory].id ?? 0])
        ApiManager.instance.connection(method, type: .get) { (response) in
            let data = try? JSONDecoder().decode(SubCategoryModel.self, from: response ?? Data())
            self.subCategories.removeAll()
            self.subCategories.append(contentsOf: data?.Categories ?? [])
            self.pickSubCategory()
        }
    }
    func pickCategory() {
        let picker = self.controller(PickerPopVC.self, storyboard: .pop)
        picker.text = Localizations.selectCategory.localized
        picker.source = categories
        picker.titleClosure = { row in
            self.categories[row].name ?? ""
        }
        picker.imageClosure = { row in
            self.categories[row].image ?? ""
        }
        picker.didSelectClosure = { row in
            self.selectedCategory = row
            self.categoryTxf.text = self.categories[row].name
        }
        self.pushPop(vcr: picker)
    }
    func pickSubCategory() {
        let picker = self.controller(PickerPopVC.self, storyboard: .pop)
        picker.text = Localizations.selectType.localized
        picker.source = subCategories
        picker.titleClosure = { row in
            self.subCategories[row].name ?? ""
        }
        picker.didSelectClosure = { row in
            self.selectedSubCategory = row
            self.typeTxf.text = self.subCategories[row].name
        }
        self.pushPop(vcr: picker)
    }
    @IBAction func cityPick(_ sender: Any) {
        let picker = self.controller(PickerPopVC.self, storyboard: .pop)
        picker.text = Localizations.selectCity.localized
        picker.source = cities
        picker.titleClosure = { row in
            self.cities[row].name ?? ""
        }
        picker.didSelectClosure = { row in
            self.selectedCity = row
            self.cityTxf.text = self.cities[row].name
        }
        self.pushPop(vcr: picker)
    }
    @IBAction func typePick(_ sender: Any) {
        fetchSubCategory()
    }
    @IBAction func categoryPick(_ sender: Any) {
        fetchCategories()
    }
    @IBAction func locationPick(_ sender: Any) {
        mapHelper?.placePicker()

    }
    
    @IBAction func next(_ sender: Any) {
        if !validate() {
            return
        }
        if editMode {
            editAd()
        } else {
            addAd()
        }
    }
    func validate() -> Bool {
        if case storeNameTxf.text?.isEmpty = true {
            storeNameTxf.attributedPlaceholder = NSAttributedString(string: storeNameTxf.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            return false
        }
        if case storeDescTxf.text?.isEmpty = true {
            storeDescTxf.attributedPlaceholder = NSAttributedString(string: storeDescTxf.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            return false
        }
        if case priceTxf.text?.isEmpty = true {
            priceTxf.attributedPlaceholder = NSAttributedString(string: priceTxf.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            return false
        }
        if case mobileTxf.text?.isEmpty = true {
            mobileTxf.attributedPlaceholder = NSAttributedString(string: mobileTxf.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            return false
        }
        if case categoryTxf.text?.isEmpty = true {
            categoryTxf.attributedPlaceholder = NSAttributedString(string: categoryTxf.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            return false
        }
        if case typeTxf.text?.isEmpty = true {
            typeTxf.attributedPlaceholder = NSAttributedString(string: typeTxf.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            return false
        }
        if case cityTxf.text?.isEmpty = true {
            cityTxf.attributedPlaceholder = NSAttributedString(string: cityTxf.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            return false
        }
        return true
    }
    func addAd() {
        guard let logoURL = logoURL else { return }
        let paramters: [String: Any] = [
            "type": "\(type)",
            "name": storeNameTxf.text ?? "",
            "desc": storeDescTxf.text ?? "",
            "price": priceTxf.text ?? "",
            "categoriesid": "\(subCategories[selectedSubCategory ?? 0].id ?? 0)",
            "city_id": "\(cities[selectedCity ?? 0].id ?? 0)",
            "phone": mobileTxf.text ?? "",
            "lat": lat ?? 0,
            "lang": lng ?? 0
        ]
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.downloaderDelegate = self
        ApiManager.instance.uploadMultiFiles(EndPoint.addAd.rawValue, type: .post, files: imagesURL, key: "images", file: ["icon": logoURL]) { (response) in
            self.navigationController?.popViewController(animated: true)
        }
    }
    func editAd() {
        
        let paramters: [String: Any] = [
            "name": storeNameTxf.text ?? "",
            "desc": storeDescTxf.text ?? "",
            "price": priceTxf.text ?? "",
            "categoriesid": "\(subCategories[selectedSubCategory ?? 0].id ?? 0)",
            "city_id": "\(cities[selectedCity ?? 0].id ?? 0)",
            "phone": mobileTxf.text ?? "",
            "lat": lat ?? 0,
            "lang": lng ?? 0
        ]
        let method = api(.editAd, [ad?.id ?? 0])
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.downloaderDelegate = self
        ApiManager.instance.uploadMultiFiles(method, type: .post, files: imagesURL, key: "images", file: ["icon": logoURL]) { (response) in
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension AddAdDetailController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width, height: collectionView.height)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = images.count
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(type: StoreSliderImageCell.self, indexPath, register: false)
        cell.image.image = images[indexPath.row]
        return cell
    }
    
    
}
extension AddAdDetailController: DownloaderDelegate, PlacesPickerDelegate {
    func didPickPlace(place: PlacePickerModel.PlacePickerResult) {
        self.locationTxf.text = place.name
        self.lat = place.coordinate.latitude
        self.lng = place.coordinate.longitude
    }
    

}
