// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let notificationModel = try? newJSONDecoder().decode(NotificationModel.self, from: jsonData)

import Foundation

// MARK: - NotificationModel
struct WishlistModel: Codable {
    let status: Bool?
    var shops: [MyStores.Datum]?
    var houseAds: [MyStores.Datum]?
    var forRent: [MyStores.Datum]?
}

