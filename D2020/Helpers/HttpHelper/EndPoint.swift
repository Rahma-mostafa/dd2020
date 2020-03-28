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
    case update = "user/update"
    case login
    case register
    case logout
    case MainCountry
    case getSections
    case SubCountry
    case getSlider
    case getSingleShop = "shop/getSingleShop"
    case rate = "shop/rate"
    case favorite = "shop/fav"
    case getCategory
    case getSubCategoryAndShop
    case shop = "shop/getShops"
    case stores = "shop/my_stores"
    case packages = "shop/get_packages"
    case add_shop_to_package = "shop/add_shop_to_package"
    case adsPackages = "Ads/get_packages"
    case myAda = "Ads/my_ad"
}
