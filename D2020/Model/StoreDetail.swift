// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let storeDetail = try? newJSONDecoder().decode(StoreDetail.self, from: jsonData)

import Foundation

// MARK: - StoreDetail
struct StoreDetail: Codable {
    let status: Bool?
    let data: StoreData?
    let message: String?
    
    // MARK: - DataClass
    struct StoreData: Codable {
        let id: Int?
        let name, desc: String?
        let image: String?
        let lat: Double?
        let video: String?
        let lang: Double?
        let phone: String?
        let cat_name: String?
        let type, rate: Int?
        var is_favorite: Bool?
        var is_comment: Bool?
        var my_comment: Comment?
        let distance: String?
        let price: Double?
        let snap, instagram, website, whatsapp: String?
        let facebook: String?
        let products: [Facilite]?
        let days: [Days]?
        var user_comment: [Comment]?
        let brand: [Image]?
        let facilites: [Facilite]?
        let images: [Image]?
    }
    
    // MARK: - Facilite
    struct Facilite: Codable {
        var id: Int?
        var name: String?
        var image: String?
        var price: Int?
    }
    // MARK: - Facilite
    struct Days: Codable {
        let id: Int?
        let name: String?
        let from: String?
        let to: String?
        let note: String?
        let type: Int?
        let key: String?
    }
    // MARK: - Facilite
    struct Comment: Codable {
        var id: Int?
        var name: String?
        var image: String?
        var rate: String?
        var comment: String?
        var created_at: String?
    }
    // MARK: - Image
    struct Image: Codable {
        let id: Int?
        let image: String?
    }

}

struct ProductModel: Codable {
    let status: Bool?
    var data: ProductData?
    var message: String?
    
    struct ProductData: Codable {
        let id: Int?
        let name: String?
        let image: String?
        let price: String?
    }
}

struct ShortStoreModel: Codable {
    let data: MyStores.Datum?
}
