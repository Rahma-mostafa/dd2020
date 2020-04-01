// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let shopsByCatID = try? newJSONDecoder().decode(ShopsByCatID.self, from: jsonData)

import Foundation

// MARK: - ShopsByCatID
struct ShopsByCatID: Codable {
    let status: Bool?
    let data: [Datum]?
    let message: String?
    // MARK: - Datum
    struct Datum: Codable {
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

        enum CodingKeys: String, CodingKey {
            case id, name, desc, image, video, phone, type
            case isFavorite = "is_favorite"
            case rate
            case catName = "cat_name"
            case distance, snap, instagram, website, whatsapp, facebook, price
        }
    }

}

