//
//  AddShopDetailsVC.swift
//  D2020
//
//  Created by Macbook on 3/9/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

protocol AddProductDelegate: class {
    func didAddProduct(product: AddProductModel?)
}
class AddProductDetailVC: BaseController {
    @IBOutlet weak var uploadImageLbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameTxf: FloatLabelTextField!
    @IBOutlet weak var productPriceTxf: FloatLabelTextField!
    @IBOutlet weak var addBtn: RoundedButton!
    
    var picker: GalleryPickerHelper?
    var image: UIImage?
    var imageURL: URL?
    weak var delegate: AddProductDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        handlers()
    }
    
    func setup() {
        picker = .init()
        uploadImageLbl.text = Localizations.uploadProductImage.localized
        addBtn.setTitle(Localizations.add.localized, for: .normal)
        productNameTxf.backgroundColor = .clear
        productPriceTxf.backgroundColor = .clear
    }
    func handlers() {
        productImage.UIViewAction {
            self.picker?.onPickImage = { image in
                self.productImage.image = image
                self.image = image
            }
            self.picker?.onPickImageURL = { url in
                self.imageURL = url
            }
            self.picker?.pick(in: self, type: .picture)
        }
        addBtn.UIViewAction {
            if self.validate() {
                let model = AddProductModel()
                model.name = self.productNameTxf.text
                model.price = self.productPriceTxf.text
                model.image = self.image
                model.url = self.imageURL
                self.delegate?.didAddProduct(product: model)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    func validate() -> Bool {
        if self.productNameTxf.text == nil || self.productPriceTxf.text == nil || image == nil {
            makeAlert("this_field_is_required.lan".localized, closure: {})
            return false
        } else {
            return true
        }
    }
}

