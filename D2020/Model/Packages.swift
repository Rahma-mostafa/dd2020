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
        let contactInfo: Int?
        let currency: String?

        enum CodingKeys: String, CodingKey {
            case id, name, price, period
            case periodType = "period_type"
            case daysWork = "days_work"
            case soicalIcon = "soical_icon"
            case video, brand, facilities, contactInfo, currency
        }
    }

}
