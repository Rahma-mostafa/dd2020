//
//  AddShopDetailsVC.swift
//  D2020
//
//  Created by Macbook on 3/9/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

protocol AddProductDelegate: class {
    func didAddProduct(product: StoreDetail.Facilite?)
    func didEditProduct(path: Int, product: StoreDetail.Facilite?)
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
    var editMode: Bool = false
    var product: StoreDetail.Facilite?
    var pathEdited: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        if editMode {
            setupEdit()
        }
        handlers()
    }
    
    func setup() {
        picker = .init()
        uploadImageLbl.text = Localizations.uploadProductImage.localized
        addBtn.setTitle(Localizations.add.localized, for: .normal)
        productNameTxf.backgroundColor = .clear
        productPriceTxf.backgroundColor = .clear
    }
    func setupEdit() {
        productImage.setImage(url: product?.image)
        productNameTxf.text = product?.name
        productPriceTxf.text = "\(product?.price ?? 0)"
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
            if self.editMode {
                self.editProduct()
            } else {
                self.addProduct()
            }
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
                let data = try? JSONDecoder().decode(ProductModel.self, from: response ?? Data())
                self.callbackDelegate(product: data?.data)
            }
        }
    }
    func editProduct() {
        if self.validateEdit() {
            let method = api(.editProduct, [product?.id ?? 0])
            let paramters: [String: Any] = [
                "name": productNameTxf.text ?? "",
                "price": productPriceTxf.text ?? ""
            ]
            ApiManager.instance.paramaters = paramters
            ApiManager.instance.downloaderDelegate = self
            ApiManager.instance.uploadFile(method, type: .post, file: ["image": imageURL]) { (response) in
                let data = try? JSONDecoder().decode(ProductModel.self, from: response ?? Data())
                self.callbackDelegate(product: data?.data)
            }
        }
    }
    func callbackDelegate(product: ProductModel.ProductData?) {
        var model = StoreDetail.Facilite()
        model.id = product?.id
        model.name = product?.name
        model.image = product?.image
        model.price = Int(product?.price ?? "0")
        if editMode {
            self.delegate?.didEditProduct(path: pathEdited ?? 0, product: model)
        } else {
            self.delegate?.didAddProduct(product: model)
        }
        self.navigationController?.popViewController(animated: true)
    }
    func validate() -> Bool {
        if case productNameTxf.text?.isEmpty = true {
            productNameTxf.attributedPlaceholder = NSAttributedString(string: productNameTxf.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            return false
        }
        if case productPriceTxf.text?.isEmpty = true {
            productPriceTxf.attributedPlaceholder = NSAttributedString(string: productPriceTxf.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            return false
        }
        if image == nil {
            makeAlert("image.is.required.lan".localized, closure: {})
            return false
        }
        return true
    }
    func validateEdit() -> Bool {
        if case productNameTxf.text?.isEmpty = true {
            productNameTxf.attributedPlaceholder = NSAttributedString(string: productNameTxf.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            return false
        }
        if case productPriceTxf.text?.isEmpty = true {
            productPriceTxf.attributedPlaceholder = NSAttributedString(string: productPriceTxf.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            return false
        }
        return true
    }
}

extension AddProductDetailVC: DownloaderDelegate {
    
}
