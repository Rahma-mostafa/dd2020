//
//  PaymentMethodVC.swift
//  D2020
//
//  Created by MacBook Pro on 3/26/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

protocol PaymentStoreDelegate: class{
    func didPaid()
}
class PaymentMethodVC: BaseController {
    
    @IBOutlet weak var chooseMethodLabel: UILabel!
    
    @IBOutlet weak var googlePayView: UIView!
    @IBOutlet weak var googlePayLbl: UILabel!
    @IBOutlet weak var googlePayImage: UIImageView!
    
    @IBOutlet weak var bankView: UIView!
    @IBOutlet weak var bankLbl: UILabel!
    @IBOutlet weak var bankImage: UIImageView!
    
    @IBOutlet weak var cashView: UIView!
    @IBOutlet weak var cashLbl: UILabel!
    @IBOutlet weak var cashImage: UIImageView!
    
    @IBOutlet weak var confirmButton: RoundedButton!
    
    var color:UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    var paymentMethod = 0
    var packageID: Int?
    var storeID:Int?
    weak var delegate: PaymentStoreDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handlers()
        setup()
        localize()
    }
    func setup() {
        
    }
    func localize() {
        googlePayLbl.text = "by.google.pay.lan".localized
        bankLbl.text = "by.bank.transfer.lan".localized
        cashLbl.text = "by.delegate.company.lan".localized
        confirmButton.setTitle("subscribe.lan".localized, for: .normal)
    }
    func addPackageToStore() {
        self.startLoading()
        let method = api(.add_shop_to_package, [storeID ?? 0] )
        ApiManager.instance.paramaters["payment_method"] = "\(paymentMethod)"
        ApiManager.instance.paramaters["package_id"] = "\(packageID ?? 0)"
        ApiManager.instance.connection(method, type: .post) { [weak self] (response) in
            self?.stopLoading()
            self?.delegate?.didPaid()
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func handlers() {
        bankView.UIViewAction {
            self.bankView.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)
            self.bankLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.bankImage.image = UIImage(named: "museum (1)")
            self.paymentMethod = 2
            self.confirmButton.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)

            self.cashView.backgroundColor = .white
            self.cashLbl.textColor = .textColor
            self.cashImage.image = UIImage(named: "Group 92")
            
            self.googlePayView.backgroundColor = .white
            self.googlePayLbl.textColor = .textColor
            self.googlePayImage.image = UIImage(named: "1280px-Google_Pay_(GPay)_Logo.svg")
            
        }
        googlePayView.UIViewAction {
            self.googlePayView.backgroundColor = .appOrange
            self.googlePayLbl.textColor = .white
            self.googlePayImage.image = UIImage(named: "google pay")
            self.paymentMethod = 3
            self.confirmButton.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)

            self.bankView.backgroundColor = .white
            self.bankLbl.textColor = .textColor
            self.bankImage.image = UIImage(named: "museum")
            
            self.cashView.backgroundColor = .white
            self.cashLbl.textColor = .textColor
            self.cashImage.image = UIImage(named: "Group 92")
        }
        cashView.UIViewAction {
            self.cashView.backgroundColor = .appOrange
            self.cashLbl.textColor = .white
            self.cashImage.image = UIImage(named: "Group 425")
            self.paymentMethod = 1
            self.confirmButton.backgroundColor = #colorLiteral(red: 0.9862338901, green: 0.6227881312, blue: 0.008487232029, alpha: 1)

            self.googlePayView.backgroundColor = .white
            self.googlePayLbl.textColor = .textColor
            self.googlePayImage.image = UIImage(named: "1280px-Google_Pay_(GPay)_Logo.svg")
            
            self.bankView.backgroundColor = .white
            self.bankLbl.textColor = .textColor
            self.bankImage.image = UIImage(named: "museum")
        }
    }

    
    @IBAction func onConfirmButtonClick(_ sender: Any) {
        addPackageToStore()
    }
    


}
