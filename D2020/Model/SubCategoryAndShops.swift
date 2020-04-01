// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let subCategoryAndShops = try? newJSONDecoder().decode(SubCategoryAndShops.self, from: jsonData)

import Foundation


// MARK: - SubCategoryAndShops
struct SubCategoryAndShops: Codable {
    let categories: [Category]?
    let shops: [Shop]?
    let data: [Shop]?
    let massege: String?
    let status: Bool?
    let ads: [Shop]?
    enum CodingKeys: String, CodingKey {
        case categories = "Categories"
        case ads = "Ads"
        case data
        case shops, massege, status
    }
    // MARK: - Category
    struct Category: Codable {
        let id: Int?
        let name: String?
        let seen: Int?
        let desc: String?
        let image: String?
    }

    // MARK: - Shop
    struct Shop: Codable {
        let id: Int?
        let name, desc: String?
        let image: String?
        let video: String?
        let phone: String?
        let type: Int?
        var isFavorite: Bool?
        let rate: Double?
        let catName, distance: String?
        let snap, instagram, website, whatsapp: String?
        let facebook: String?
        let price: Double?
        
        //let days, brand: [String]?
        //let facilites: [Facilite]?
        //let images: [Image]?

        enum CodingKeys: String, CodingKey {
            case id, name, desc, image, video, phone, type
            case isFavorite = "is_favorite"
            case rate
            case catName = "cat_name"
            case distance, snap, instagram, website, whatsapp, facebook, price
        }
    }

    // MARK: - Facilite
    struct Facilite: Codable {
        let id: Int?
        let name: String?
        let image: String?
        let price: Int?
    }

    // MARK: - Image
    struct Image: Codable {
        let id: Int?
        let image: String?
    }

}

