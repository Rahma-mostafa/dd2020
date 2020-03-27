//
//  PremiumContacts.swift
//  D2020
//
//  Created by Macbook on 3/4/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit


class StorePremuiemInfo: BaseController {
    
    @IBOutlet weak var productLbl: UILabel!
    @IBOutlet weak var productsCollection: UICollectionView!
    @IBOutlet weak var facilitesLbl: UILabel!
    @IBOutlet weak var facilitiesCollection: UICollectionView!
    @IBOutlet weak var brandsLbl: UILabel!
    @IBOutlet weak var brandsCollection: UICollectionView!
    
    static weak var instance: StorePremuiemInfo?
    override func viewDidLoad() {
        super.hiddenNav = true
        super.viewDidLoad()
        StorePremuiemInfo.instance = self
        setup()
    }
    func setup() {
        productLbl.text = Localizations.products.localized
        facilitesLbl.text = Localizations.facilites.localized
        brandsLbl.text = Localizations.brands.localized

        productsCollection.delegate = self
        productsCollection.dataSource = self
        facilitiesCollection.delegate = self
        facilitiesCollection.dataSource = self
        brandsCollection.delegate = self
        brandsCollection.dataSource = self
    }
    func reload() {
        productsCollection.reloadData()
        facilitiesCollection.reloadData()
        brandsCollection.reloadData()

    }
}

extension StorePremuiemInfo: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == brandsCollection || collectionView == facilitiesCollection {
            return CGSize(width: 60, height: 60)
        } else {
            return CGSize(width: 112, height: 152)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == brandsCollection {
            return StorePremuimController.storePrem?.brand?.count ?? 0
        } else if collectionView == facilitiesCollection {
            return StorePremuimController.storePrem?.facilites?.count ?? 0
        } else {
            return StorePremuimController.storePrem?.products?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == brandsCollection {
            var cell = collectionView.cell(type: StoreSliderImageCell.self, indexPath, register: false)
            cell.model = StorePremuimController.storePrem?.brand?[indexPath.row].image
            return cell
        } else if collectionView == facilitiesCollection {
            var cell = collectionView.cell(type: StoreSliderImageCell.self, indexPath, register: false)
            cell.model = StorePremuimController.storePrem?.facilites?[indexPath.row].image
            return cell
        } else {
            var cell = collectionView.cell(type: StoreProductCollectionCell.self, indexPath, register: false)
            cell.model = StorePremuimController.storePrem?.products?[indexPath.row]
            return cell
        }
    }
}

