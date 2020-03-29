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
    
    
    var adsArray:[Ads] = [Ads(image: "food", label: "cnhjbc" , label2:  "20"),Ads(image: "food", label: "cnhjbc" , label2:  "20"),Ads(image: "food", label: "cnhjbc" , label2:  "20"),Ads(image: "food", label: "cnhjbc" , label2:  "20")]
    var ads:Int? = 11
    var packagesArray:[AdsPackages.Datum] = []
//    var myAdsArray:[MyAds.Datum] = []
    
    
    var color:UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    var packageID = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButton.layer.cornerRadius = 12
        confirmImageView.layer.cornerRadius = 12
        
        setup()
        fetchAdsPackage()
//        fetchMyAds()

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
//            ApiManager.instance.paramaters["Ads_id"] = "\(ads ?? 0)"
            ApiManager.instance.connection(.adsPackages, type: .get) { [weak self] (response) in
            self?.stopLoading()
            let data = try? JSONDecoder().decode(AdsPackages.self, from: response ?? Data())
                if case data?.status = true {
                    self?.packagesArray.append(contentsOf: data?.data ?? [])
                    self?.adsPeriodCollectionView.reloadData()
                }
          }
    }
//    func fetchMyAds() {
//        startLoading()
//            ApiManager.instance.connection(.myAda, type: .get) { [weak self] (response) in
//            self?.stopLoading()
//            let data = try? JSONDecoder().decode(MyAds.self, from: response ?? Data())
//                if case data?.status = true {
//                    self?.myAdsArray.append(contentsOf: data?.data ?? [])
//                    self?.rentAdsTableView.reloadData()
//                }
//          }
//    }
//
    
    @IBAction func onExitButtonClick(_ sender: Any) {
        self.dismiss(animated: true )
    }
    
   

}
extension ForRentAdsVC: UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return myAdsArray.count
        return adsArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = rentAdsTableView.dequeueReusableCell(withIdentifier: "RentAdsCell", for: indexPath) as? ForRentAdsCell{
//            cell.didSelectedImg.setImage(url: adsArray[indexPath.row].image)
            cell.didSelectedImg.image = UIImage (named: "dean-rose-Y0qKkSuVzWE-unsplash")
            cell.didSelectedTitle.text = adsArray[indexPath.item].label!
//            cell.didSelectedKm.text = myAdsArray[indexPath.item]
            cell.priceLabel.text = "\(adsArray[indexPath.item].label2!)"
//            cell.starView.rating = Double(adsArray[indexPath.item].rate!)
            
            return cell
        }
         return UITableViewCell()
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return packagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = adsPeriodCollectionView.dequeueReusableCell(withReuseIdentifier: "PeriodCell", for: indexPath)as? AdsPeriodCell {
            cell.periodLabel.text = packagesArray[indexPath.item].periodType
            cell.priceLabel.text = "\(String(describing: packagesArray[indexPath.item].price))" + "\(String(describing: packagesArray[indexPath.item].currency))"
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.45
            , height: 100.0)
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        packageID += 1
     }
    @IBAction func onConfirmButtonClick(_ sender: Any) {
           confirmButton.backgroundColor = #colorLiteral(red: 0.9746131301, green: 0.6148713231, blue: 0.004504605196, alpha: 1)
           confirmImageView.backgroundColor = #colorLiteral(red: 0.9319314361, green: 0.5832290053, blue: 0.00618581241, alpha: 1)
           let scene = controller(PaymentMethodVC.self , storyboard: .Upgrade )
              scene.package = packageID
              navigationController?.pushViewController(scene, animated: true)
        
       }
    
    
    
}
