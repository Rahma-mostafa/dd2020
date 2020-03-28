// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let myStores = try? newJSONDecoder().decode(MyStores.self, from: jsonData)

import Foundation

// MARK: - MyStores
struct MyStores: Codable {
    let status: Bool?
    let data: [Datum]?
    let message: String?
    // MARK: - Datum
    struct Datum: Codable {
        var id: Int?
        var name, desc: String?
        var image: String?
        var video: String?
        var phone: String?
        var type: Int?
        var isFavorite, isComment: Bool?
        var rate: Int?
        var catName: String?
        var distance: String?
        var snap, instagram, website, whatsapp: String?
        var twitter, facebook: String?
       

        enum CodingKeys: String, CodingKey {
            case id, name, desc, image, video, phone, type
            case isFavorite = "is_favorite"
            case isComment = "is_comment"
            case rate
            case catName = "cat_name"
            case distance, snap, instagram, website, whatsapp, twitter, facebook
        }
    }

}

