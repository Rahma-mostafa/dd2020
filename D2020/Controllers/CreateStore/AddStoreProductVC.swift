//
//  AddShopDetailsVC.swift
//  D2020
//
//  Created by Macbook on 3/9/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class AddStoreProductVC: BaseController {
    @IBOutlet weak var sliderCollection: UICollectionView!
    @IBOutlet weak var storeLogo: UIImageView!
    @IBOutlet weak var addProductLbl: UILabel!
    @IBOutlet weak var addProductBtn: RoundedButton!
    @IBOutlet weak var confirmBtn: RoundedButton!
    @IBOutlet weak var productCollection: UICollectionView!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    
    var images: [UIImage] = []
    var storeImage: UIImage?
    var products: [StoreDetail.Facilite] = []
    var storeID: Int?
    
    var editMode: Bool = false
    var store: StoreDetail.StoreData?
    
    override func viewDidLoad() {
        super.hiddenNav = true
        
        super.viewDidLoad()
        setup()
        if editMode {
            setupEdit()
        }
        handlers()
    }
    
    func setup() {
        addProductLbl.text = Localizations.products.localized
        addProductBtn.setTitle(Localizations.addProduct.localized, for: .normal)
        confirmBtn.setTitle(Localizations.confirm.localized, for: .normal)
        storeLogo.image = storeImage
        sliderCollection.delegate = self
        sliderCollection.dataSource = self
        productCollection.delegate = self
        productCollection.dataSource = self
        
        containerHeight.constant -= 300
        
    }
    func setupEdit() {
        storeLogo.setImage(url: store?.image)
        self.products.append(contentsOf: store?.products ?? [])
        self.reload()
    }
    func handlers() {
        addProductBtn.UIViewAction {
            let vc = self.controller(AddProductDetailVC.self, storyboard: .createStore)
            vc.delegate = self
            vc.storeID = self.storeID
            self.push(vc)
        }
        confirmBtn.UIViewAction {
            if self.products.count > 0 {
                let vc = self.controller(MyShopsVC.self, storyboard: .createStore)
                self.push(vc)
            }
        }
    }
    func reload() {
        confirmBtn.backgroundColor = .appOrange
        if products.count > 0 && products.count < 4 {
            containerHeight.constant = 200
            self.productCollection.reloadData()
        } else if products.count > 4 {
            containerHeight.constant += 100
            self.productCollection.reloadData()
        }
        
    }
}

extension AddStoreProductVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == sliderCollection {
            return CGSize(width: collectionView.width, height: collectionView.height)
        } else {
            return CGSize(width: 104, height: 156)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sliderCollection {
            if editMode {
                return store?.images?.count ?? 0
            } else {
                return images.count
            }
        } else {
            return products.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sliderCollection {
            if editMode {
                let cell = collectionView.cell(type: StoreSliderImageCell.self, indexPath, register: false)
                cell.image.setImage(url: store?.images?[indexPath.row].image)
                return cell
            } else {
                let cell = collectionView.cell(type: StoreSliderImageCell.self, indexPath, register: false)
                cell.image.image = images[indexPath.row]
                return cell
                
            }
           
            
        } else {
            var cell = collectionView.cell(type: AddProductStoreCell.self, indexPath, register: false)
            cell.model = products[indexPath.row]
            return cell

        }
       
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == productCollection {
            let actions = ["edit.lan".localized: 1, "delete.lan".localized: 2]
            createActionSheet(title: "options.lan".localized, actions: actions) { (data) in
                guard let val = data.values.first as? Int else { return }
                if val == 1 {
                    self.editProduct(path: indexPath.row)
                } else if val == 2 {
                    self.didDeleteProduct(path: indexPath.row)
                }
            }
        }
      
    }
}
extension AddStoreProductVC: AddProductDelegate {
    func editProduct(path: Int) {
        let vc = self.controller(AddProductDetailVC.self, storyboard: .createStore)
        vc.delegate = self
        vc.storeID = self.storeID
        vc.product = self.products[path]
        vc.pathEdited = path
        vc.editMode = true
        self.push(vc)
    }
    func didDeleteProduct(path: Int) {
        let method = api(.deleteProduct, [products[path].id ?? 0])
        ApiManager.instance.connection(method, type: .post) { (response) in
            self.products.remove(at: path)
            self.reload()
        }
    }
    func didAddProduct(product: StoreDetail.Facilite?) {
        guard let product = product else { return }
        self.products.append(product)
        self.reload()
    }
    func didEditProduct(path: Int, product: StoreDetail.Facilite?) {
        guard let product = product else { return }
        var productEdited = products[path]
        productEdited = product
        products.remove(at: path)
        products.insert(productEdited, at: path)
        self.reload()
    }
}
