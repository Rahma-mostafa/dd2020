// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Section: Codable {
    let status: Bool?
    let data: [Data]?
    let message: String?
    
    // MARK: - Datum
    struct Data: Codable {
        let id: Int?
        let name: String?
        let style: Int?
        let registerLike, color: String?
        let image: String?
    }

}

