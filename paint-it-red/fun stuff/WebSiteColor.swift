//
//  Model.swift
//  paint-it-red
//
//  Created by Kukushkin, Vladimir on 24.9.2021.
//

import Foundation
import SwiftUI

struct WebSiteColor: Codable, Identifiable, Equatable {
    let id: UUID
    var host: String
    var hexColor: String

    public init(host: String, hexColor: String) {
        self.id = UUID()
        self.host = host
        self.hexColor = hexColor
    }
}

// Safari App Extension protocol dictionary encoding
extension WebSiteColor {
    init?(from json: Any) {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []),
              let decoded = try? JSONDecoder().decode(WebSiteColor.self, from: jsonData) else {
            return nil
        }
        self.id = UUID()
        self.host = decoded.host
        self.hexColor = decoded.hexColor
    }

    func encode() throws -> Any {
        let jsonData = try JSONEncoder().encode(self)
        return try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
    }
}
