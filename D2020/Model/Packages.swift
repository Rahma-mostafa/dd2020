// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let packages = try? newJSONDecoder().decode(Packages.self, from: jsonData)

import Foundation

// MARK: - Packages
struct Packages: Codable {
    let status: Bool?
    let data: [Datum]?
    let message: String?
    // MARK: - Datum
    struct Datum: Codable {
        let id: Int?
        let name: String?
        let price: Int?
        let period, periodType: String?
        let daysWork: Int?
        let soicalIcon: Int?
        let video, brand, facilities: Int?
        let contactInfo: JSONNull?
        let currency: String?

        enum CodingKeys: String, CodingKey {
            case id, name, price, period
            case periodType = "period_type"
            case daysWork = "days_work"
            case soicalIcon = "soical_icon"
            case video, brand, facilities, contactInfo, currency
        }
    }

    // MARK: - Encode/decode helpers

    class JSONNull: Codable, Hashable {

        public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
        }

        public var hashValue: Int {
            return 0
        }

        public init() {}

        public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
    }



  
}
