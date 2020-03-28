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
    var storeID: Int?
    
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
            self.addProduct()
        }
    }
    func addProduct() {
        if self.validate() {
            guard let imageURL = imageURL else { return }
            let method = api(.addProduct, [storeID ?? 0])
            let paramters: [String: Any] = [
                "name": productNameTxf.text ?? "",
                "price": productPriceTxf.text ?? ""
            ]
            ApiManager.instance.paramaters = paramters
            ApiManager.instance.downloaderDelegate = self
            ApiManager.instance.uploadFile(method, type: .post, file: ["image": imageURL]) { (response) in
                self.callbackDelegate()
            }
        }
    }
    func callbackDelegate() {
        let model = AddProductModel()
        model.name = self.productNameTxf.text
        model.price = self.productPriceTxf.text
        model.image = self.image
        model.url = self.imageURL
        self.delegate?.didAddProduct(product: model)
        self.navigationController?.popViewController(animated: true)
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

extension AddProductDetailVC: DownloaderDelegate {
    
}
