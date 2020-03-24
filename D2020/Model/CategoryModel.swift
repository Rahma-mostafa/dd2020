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
    let type: Int?

    enum CodingKeys: String, CodingKey {
        case date, massege, status
        case userPermission = "UserPermission"
        case type
    }
    // MARK: - DateElement
    struct DateElement: Codable {
        let id: Int?
        let name: String?
        let seen: Int?
        let desc: JSONNull2?
        let image: String?
    }

}


// MARK: - Encode/decode helpers

class JSONNull2: Codable, Hashable {

    public static func == (lhs: JSONNull2, rhs: JSONNull2) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull2.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
