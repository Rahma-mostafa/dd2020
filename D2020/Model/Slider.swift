// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let slider = try? newJSONDecoder().decode(Slider.self, from: jsonData)

import Foundation

// MARK: - Slider
struct Slider: Codable {
    let status: Bool?
    let data: [Data]?
    let message: String?
    
    // MARK: - Datum
    struct Data: Codable {
        let id, imageOrVideo: Int?
        let file: String?
        let status, type: Int?
        let title, desc: String?
    }

}

