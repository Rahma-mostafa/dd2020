// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let category = try? newJSONDecoder().decode(Category.self, from: jsonData)

import Foundation

// MARK: - Category
struct Category: Codable {
    let date: [DateElement]?
    let massege: String?
    let status, userPermission: Bool?
    //let type: Int?

    enum CodingKeys: String, CodingKey {
        case date, massege, status
        case userPermission = "UserPermission"
        //case type
    }
    // MARK: - DateElement
    struct DateElement: Codable {
        let id: Int?
        let name: String?
        let seen: Int?
        let desc: String?
        let image: String?
    }

}

