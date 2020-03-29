//
//  AddShopDetailsVC.swift
//  D2020
//
//  Created by Macbook on 3/9/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import PlacesPicker
import GooglePlaces

class AddShopDetailVC: BaseController {
    @IBOutlet weak var sliderCollection: UICollectionView!
    @IBOutlet weak var noPhotoImage: UIImageView!
    @IBOutlet weak var addImageLbl: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var storeLogoImage: UIImageView!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var storeNameTxf: UITextField!
    @IBOutlet weak var storeDescTxf: UITextField!
    @IBOutlet weak var mobileTxf: UITextField!
    @IBOutlet weak var categoryTxf: UITextField!
    @IBOutlet weak var typeTxf: UITextField!
    @IBOutlet weak var cityTxf: UITextField!
    @IBOutlet weak var locationTxf: UITextField!
    @IBOutlet weak var nextBtn: RoundedButton!

    var picker: GalleryPickerHelper?
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
    var sotre: StoreDetail.StoreData?
    var editMode: Bool = false
    override func viewDidLoad() {
        super.hiddenNav = true
        super.viewDidLoad()
        setup()
        handlers()
    }
    func setup() {
        addImageLbl.text = Localizations.addImages.localized
        nextBtn.setTitle(Localizations.next.localized, for: .normal)
        picker = GalleryPickerHelper()
        PlacePicker.configure(googleMapsAPIKey: Constants.googleAPI, placesAPIKey:  Constants.googleAPI)

        sliderCollection.delegate = self
        sliderCollection.dataSource = self
        
        fetchCities()
    }
    func setupEdit() {
        
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
        let method = api(.getCategory, [14])
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
        let method = api(.getSubCategoryAndShop, [categories[selectedCategory ?? 0].id ?? 0])
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
        let controller = PlacePicker.placePickerController()
        controller.delegate = self
        let navigationController = UINavigationController(rootViewController: controller)
        self.show(navigationController, sender: nil)
    }
    
    @IBAction func next(_ sender: Any) {
        guard let logoURL = logoURL else { return }
        let paramters: [String: Any] = [
            "name": storeNameTxf.text ?? "",
            "desc": storeDescTxf.text ?? "",
            "categoriesid": "\(subCategories[selectedSubCategory ?? 0].id ?? 0)",
            "city_id": "\(cities[selectedCity ?? 0].id ?? 0)",
            "phone": mobileTxf.text ?? "",
            "lat": lat ?? 0,
            "lang": lng ?? 0
        ]
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.downloaderDelegate = self
        ApiManager.instance.uploadMultiFiles(EndPoint.addShop.rawValue, type: .post, files: imagesURL, key: "images", file: ["logo": logoURL]) { (response) in
            let data = try? JSONDecoder().decode(StoreDetail.self, from: response ?? Data())
            let vc = self.controller(AddStoreProductVC.self, storyboard: .createStore)
            vc.storeID = data?.data?.id
            vc.images = self.images
            vc.storeImage = self.logo
            self.push(vc)
        }
    }

}

extension AddShopDetailVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
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
extension AddShopDetailVC: PlacesPickerDelegate, DownloaderDelegate {
    func placePickerControllerDidCancel(controller: PlacePickerController) {
         self.dismiss(animated: true, completion: nil)
    }
    
    func placePickerController(controller: PlacePickerController, didSelectPlace place: GMSPlace) {
        self.dismiss(animated: true) {
            self.locationTxf.text = place.formattedAddress
            self.lat = place.coordinate.latitude
            self.lng = place.coordinate.longitude
        }
    }
    
    
}