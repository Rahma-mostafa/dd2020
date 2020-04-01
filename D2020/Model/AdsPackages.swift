// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let adsPackages = try? newJSONDecoder().decode(AdsPackages.self, from: jsonData)

import Foundation

// MARK: - AdsPackages
struct AdsPackages: Codable {
    let status: Bool?
    let data: [Datum]?
    let message: String?

    // MARK: - Datum
    struct Datum: Codable {
        let id: Int?
        let name: String?
        let price: Int?
        let currency: String?
        let period: Int?
        let periodType: String?

        enum CodingKeys: String, CodingKey {
            case id, name, price, currency, period
            case periodType = "period_type"
        }
    }

}
