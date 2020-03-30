//
//  EndPoint.swift
//  SupportI
//
//  Created by Mohamed Abdu on 3/20/20.
//  Copyright © 2020 MohamedAbdu. All rights reserved.
//

import Foundation

public enum EndPoint: String {
    case token
    case update = "user/editData"
    case editPassword = "user/editPassword"
    case userInfo = "user/userData"
    case login
    case register = "Register"
    case logout
    case MainCountry
    case getSections
    case SubCountry
    case getSlider
    case getSingleAd = "Ads/getSingleAds"
    case getSingleShop = "shop/getSingleShop"
    case rate = "shop/rate"
    case adsRate = "Ads/rate"
    case favorite = "shop/fav"
    case adsFavorite = "Ads/fav"
    case getCategory = "getCategory"
    case getSubCategoryAndShop
    case getSubCategoryAndAds
    case shop = "shop/getShops"
    case getAds = "Ads/getAds"
    case stores = "shop/my_stores"
    case myAds = "Ads/my_ad"
    case deleteStore = "shop/delete_my_store"
    case deleteAd = "Ads/delete_my_ad"
    case packages = "shop/get_packages"
    case add_shop_to_package = "shop/add_shop_to_package"
    case updateLat = "user/updateLat"
    case addShop = "shop/add_shop"
    case addProduct = "shop/add_product_toStore"
    case upgradeSections = "user/get_upgrade_to"
    case upgradeAccount = "user/upgrade_to"
}
