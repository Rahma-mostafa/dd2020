//
//  PackageVC.swift
//  D2020
//
//  Created by MacBook Pro on 3/25/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

protocol PackageDelegate: class {
    func didSelectPackage(package: Int)
}
class PackageVC: BaseController {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var label8: UILabel!
    @IBOutlet weak var label9: UILabel!
    @IBOutlet weak var label10: UILabel!
    @IBOutlet weak var label12: UILabel!
    @IBOutlet weak var cornerView: UIView!
    @IBOutlet weak var imageView: RoundedImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var package1Button: UIButton!
    @IBOutlet weak var backView2: UIView!
    @IBOutlet weak var package2Button: UIButton!
    @IBOutlet weak var label14: UILabel!
    @IBOutlet weak var subscribeLbl: UILabel!
    
    
    var packagesArray:[Packages.Datum] = []
    var color:UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    var selectedPackage: Int?
    var storeID: Int?
    weak var delegate: PackageDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hiddenNav = true
        fetchPackages()
        setup()
        localize()
    }
    
    func setup() {
        cornerView.layer.cornerRadius = 12
        imageView.layer.cornerRadius = 12
        backView.layer.cornerRadius = 12
        package1Button.layer.cornerRadius = 12
        backView2.layer.cornerRadius = 12
        package2Button.layer.cornerRadius = 12
        
    }
    func localize() {
        label1.text = "upgrade.for.lan".localized
        label2.text = "special.store.lan".localized
        label3.text = "trust.account.lan".localized
        label4.text = "show_products_and_prices.lan".localized
        label5.text = "example.wifi.lan".localized
        label6.text = "barnds.available.for.store.lan".localized
        label7.text = "example.pepsi.lan".localized
        label8.text = "display.work.times.lan".localized
        label9.text = "add.social.links.lan".localized
        label10.text = "add.video.for.store.lan".localized
        subscribeLbl.text = "subscribe.payment.lan".localized
    }
    func fetchPackages() {
        let method = api(.packages, [storeID ?? 0])
        ApiManager.instance.connection(method, type: .get) { (response) in
            self.stopLoading()
            let data = try? JSONDecoder().decode(Packages.self, from: response ?? Data())
            if case data?.status = true {
                self.packagesArray.append(contentsOf: data?.data ?? [])
                if self.packagesArray.isset(0) {
                    let package = self.packagesArray[0]
                    self.label12.text = "\(package.periodType ?? "") / \(package.price ?? 0) \(package.currency ?? "")"
                } else {
                    self.backView.removeFromSuperview()
                }
                if self.packagesArray.isset(1) {
                    let package = self.packagesArray[0]
                    self.label14.text = "\(package.periodType ?? "") / \(package.price ?? 0) \(package.currency ?? "")"
                } else {
                    self.backView2.removeFromSuperview()
                }
            }
        }
    }
    @IBAction func onFirstButttonClick(_ sender: Any) {
        package1Button.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
        backView.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
        label12.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        package2Button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        backView2.backgroundColor = #colorLiteral(red: 0.4352535307, green: 0.4353200793, blue: 0.435239017, alpha: 1)
        label14.textColor = #colorLiteral(red: 0.4352535307, green: 0.4353200793, blue: 0.435239017, alpha: 1)
        
        if self.packagesArray.isset(0) {
            selectedPackage = self.packagesArray[0].id ?? 0
        }
    }
    
    @IBAction func onsecondButtonClick(_ sender: Any) {
        package2Button.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
        backView2.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
        label14.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        package1Button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        backView.backgroundColor = #colorLiteral(red: 0.4355352521, green: 0.4425930679, blue: 0.4776369929, alpha: 1)
        label12.textColor = #colorLiteral(red: 0.4355352521, green: 0.4425930679, blue: 0.4776369929, alpha: 1)
        
        if self.packagesArray.isset(1) {
            selectedPackage = self.packagesArray[1].id ?? 0
        }
        
    }
    
    @IBAction func onButtonClick(_ sender: Any) {
        self.dismiss(animated: true) {
            if let package = self.selectedPackage {
                self.delegate?.didSelectPackage(package: package)
            }
        }
    }
    
    @IBAction func onExitButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

