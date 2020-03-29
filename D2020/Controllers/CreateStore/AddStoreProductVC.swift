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
    var products: [AddProductModel] = []
    var storeID: Int?
    override func viewDidLoad() {
        super.hiddenNav = true
        
        super.viewDidLoad()
        setup()
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
            containerHeight.constant += 200
            self.productCollection.reloadData()
        } else {
            containerHeight.constant += 200
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
            return images.count
        } else {
            return products.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sliderCollection {
            let cell = collectionView.cell(type: StoreSliderImageCell.self, indexPath, register: false)
            cell.image.image = images[indexPath.row]
            return cell
            
        } else {
            var cell = collectionView.cell(type: AddProductStoreCell.self, indexPath, register: false)
            cell.model = products[indexPath.row]
            return cell
            
        }
       
    }
    
}
extension AddStoreProductVC: AddProductDelegate {
    func didAddProduct(product: AddProductModel?) {
        guard let product = product else { return }
        self.products.append(product)
        self.reload()
    }
}
