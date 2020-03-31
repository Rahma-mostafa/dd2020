// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let notificationModel = try? newJSONDecoder().decode(NotificationModel.self, from: jsonData)

import Foundation

// MARK: - NotificationModel
struct NotificationModel: Codable {
    let status: Bool?
    let data: [Datum]?
    let message: String?
    
    // MARK: - Datum
    struct Datum: Codable {
        let id: Int?
        let title, content, date, image: String?
    }
}

