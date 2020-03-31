//
//  ForRentAdsVC.swift
//  D2020
//
//  Created by MacBook Pro on 3/27/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit
import Alamofire
struct Ads {
    var image : String?
    var label : String?
    var label2 : String?
}

class ForRentAdsVC: BaseController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rentAdsTableView: UITableView!
    @IBOutlet weak var adsPeriodCollectionView: UICollectionView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var confirmLabel: UILabel!
    @IBOutlet weak var confirmImageView: RoundedImageView!
    @IBOutlet weak var adsPeriodLabel: UILabel!
    @IBOutlet weak var chooseLabel: UILabel!
    
    
    
    var adsID:Int?
    var packagesArray: [AdsPackages.Datum] = []
    var myAdsArray:[MyStores.Datum] = []
    
    var style: Style = .green
    var color:UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    var packageSelected: Int?
    weak var delegate: PackageDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButton.layer.cornerRadius = 12
        confirmImageView.layer.cornerRadius = 12
        
        setup()
        fetchAdsPackage()
        fetchMyAds()

    }
    func setupLocalization(){
        titleLabel.text = "mark.product.lan".localized
        adsPeriodLabel.text = "ads.period.lan".localized
        chooseLabel.text = "select.period.lan".localized
        confirmLabel.text = "payments.sub.lan".localized
        
    }
    func setup() {
        rentAdsTableView.delegate = self
        rentAdsTableView.dataSource = self
        adsPeriodCollectionView.delegate = self
        adsPeriodCollectionView.dataSource = self
    }
    func fetchAdsPackage() {
        startLoading()
        let method = api(.adsPackages, [adsID ?? 0])
        ApiManager.instance.connection(method, type: .get) { [weak self] (response) in
            self?.stopLoading()
            let data = try? JSONDecoder().decode(AdsPackages.self, from: response ?? Data())
            if case data?.status = true {
                self?.packagesArray.append(contentsOf: data?.data ?? [])
                self?.adsPeriodCollectionView.reloadData()
            }
        }
    }
    func fetchMyAds() {
        startLoading()
            ApiManager.instance.connection(.myAds, type: .get) { [weak self] (response) in
            self?.stopLoading()
            let data = try? JSONDecoder().decode(MyStores.self, from: response ?? Data())
                if case data?.status = true {
                    self?.myAdsArray.append(contentsOf: data?.data ?? [])
                    self?.rentAdsTableView.reloadData()
                }
          }
    }

    
    @IBAction func onExitButtonClick(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onConfirmButtonClick(_ sender: Any) {
        self.dismiss(animated: true) {
            if let package = self.packageSelected {
                self.delegate?.didSelectPackage(package: self.packagesArray[package].id ?? 0)
            }
        }
        
    }

}
extension ForRentAdsVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return packagesArray.count
//        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(type: AdsPeriodCell.self, indexPath, register: false)
        cell.periodLabel.text = packagesArray[indexPath.item].periodType
        cell.priceLabel.text = "\(String(describing: packagesArray[indexPath.item].price))" + "\(String(describing: packagesArray[indexPath.item].currency))"
        cell.selectButton.tag = indexPath.row
        if packageSelected != nil && packageSelected == indexPath.row {
            cell.roundedView.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
            cell.whiteView.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
            cell.periodLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.priceLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
            cell.roundedView.backgroundColor = .textColor
            cell.whiteView.backgroundColor = .white
            cell.periodLabel.textColor = .textColor
            cell.priceLabel.textColor = .textColor
        }
        cell.onButtonTapped = {
            self.packageSelected = indexPath.row
            self.confirmButton.backgroundColor = #colorLiteral(red: 0.9746131301, green: 0.6148713231, blue: 0.004504605196, alpha: 1)
            self.confirmImageView.backgroundColor = #colorLiteral(red: 0.9319314361, green: 0.5832290053, blue: 0.00618581241, alpha: 1)
            collectionView.reloadData()
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.45
            , height: 100.0)
    }
    
  
    
    
    
}

extension ForRentAdsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myAdsArray.count
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
        cell.imageSelected.setImage(url: myAdsArray[indexPath.row].image)
        cell.titleSelected.text = myAdsArray[indexPath.row].name
        cell.kmSelected.text = myAdsArray[indexPath.row].distance
        cell.ratingView.rating = Double(myAdsArray[indexPath.row].rate ?? 0)
        cell.categoryBtn.setTitle("\(myAdsArray[indexPath.row].price ?? 0)", for: .normal)
        return cell
        
    }
}
