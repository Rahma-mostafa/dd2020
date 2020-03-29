//
//  PaymentMethodVC.swift
//  D2020
//
//  Created by MacBook Pro on 3/26/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class  PaymentMethodVC: BaseController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chooseMethodLabel: UILabel!
    
    @IBOutlet weak var backgroundView1: RoundedShadowView!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var bankImageView: UIImageView!
    
    @IBOutlet weak var backgroundView2: RoundedShadowView!
    @IBOutlet weak var cashLabel: UILabel!
    @IBOutlet weak var bankButton: RoundedButton!
    @IBOutlet weak var cashImageView: UIImageView!
    @IBOutlet weak var cashButton: RoundedButton!
    @IBOutlet weak var confirmButton: RoundedButton!
    
    var color:UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    var store:Int? = 12
    var paymentMethod = 0
    var package = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hiddenNav = true
        SetupLocalization()

    }
    func SetupLocalization(){
        titleLabel.text = "payment.lan".localized
        chooseMethodLabel.text = "selectMethod.lan".localized
        bankLabel.text = "bank.lan".localized
        cashLabel.text = "cash.lan".localized
        confirmButton.setTitle("subscription".localized, for: .normal)
    

    }
    func fetchPaymentMethod() {
        let method = api(.add_shop_to_package, [store ?? 0] )
        ApiManager.instance.headers["store_id"] = "\(store ?? 0)"
        ApiManager.instance.paramaters["payment_method"] = "\(paymentMethod )"
        ApiManager.instance.paramaters["package_id"] = "\(package )"
        ApiManager.instance.connection(method, type: .post) { [weak self] (response) in
            self?.stopLoading()
   
         

        }
    }
    @IBAction func onBankButtonClick(_ sender: Any) {
        bankButton.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
        backgroundView1.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
        bankLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        bankImageView.image = UIImage(named: "museum (1)")
        paymentMethod = 1
        
        
    }
    
    @IBAction func onCashButtonClick(_ sender: Any) {
        cashButton.backgroundColor =  #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
    backgroundView2.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
        cashLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cashImageView.image = UIImage(named: "Group 425")
        paymentMethod = 2
        
    }
    
    
    @IBAction func onConfirmButtonClick(_ sender: Any) {
        confirmButton.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
        fetchPaymentMethod()

        
    }
    


}
