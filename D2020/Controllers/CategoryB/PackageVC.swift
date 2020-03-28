//
//  PackageVC.swift
//  D2020
//
//  Created by MacBook Pro on 3/25/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class
PackageVC: BaseController {
    
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
    
    
    var store:Int? = 12
    var packagesArray:[Packages.Datum] = []
    var color:UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    var id = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hiddenNav = true
        cornerView.layer.cornerRadius = 12
        imageView.layer.cornerRadius = 12
        backView.layer.cornerRadius = 12
        package1Button.layer.cornerRadius = 12
        backView2.layer.cornerRadius = 12
        package2Button.layer.cornerRadius = 12
        
        fetchPackages()
    }
    
    func fetchPackages() {
           let method = api(.packages, [store ?? 0] )
           ApiManager.instance.headers["store_id"] = "\(store ?? 0)"
           ApiManager.instance.connection(method, type: .get) { [weak self] (response) in
               self?.stopLoading()
               let data = try? JSONDecoder().decode(Packages.self, from: response ?? Data())
               if case data?.status = true {
                   self?.packagesArray.append(contentsOf: data?.data ?? [])
                   let price = "\(self!.packagesArray[0].price!)"
                   let periodType = "\(self!.packagesArray[0].periodType!)"
                   let currency = "\(self!.packagesArray[0].currency!)"
                   self?.label12.text =  periodType + " / " + price + currency
                   let price2 = "\(self!.packagesArray[1].price!)"
                   let periodType2 = "\(self!.packagesArray[1].periodType!)"
                   let currency2 = "\(self!.packagesArray[1].currency!)"
                   self?.label14.text =  periodType2 + " / " + price2 + currency2
              
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
        id = 3
    }
    
    @IBAction func onsecondButtonClick(_ sender: Any) {
        package2Button.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
        backView2.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
        label14.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        package1Button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        backView.backgroundColor = #colorLiteral(red: 0.4355352521, green: 0.4425930679, blue: 0.4776369929, alpha: 1)
        label12.textColor = #colorLiteral(red: 0.4355352521, green: 0.4425930679, blue: 0.4776369929, alpha: 1)
        id = 4
    }
    
    @IBAction func onButtonClick(_ sender: Any) {
        let scene = controller(PaymentMethodVC.self , storyboard: .Upgrade )
        scene.package = id
        navigationController?.pushViewController(scene, animated: true)
    }
    
    @IBAction func onExitButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }

    
}
