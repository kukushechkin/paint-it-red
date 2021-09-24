//
//  ViewModel.swift
//  paint-it-red
//
//  Created by Kukushkin, Vladimir on 24.9.2021.
//

import Foundation

let lastKnownExtensionStateKey = "lastKnownExtensionState"

class ViewModel: ObservableObject {
    @Published var websites: [WebSiteColor] = []
    private let defaults = UserDefaults(suiteName: "AC5986BBE6.com.kukushechkin.PaintItRed.appGroup")

    public init() {
        self.websites = (self.defaults?.object(forKey: lastKnownExtensionStateKey) as? [Any] ?? []).map({ decoded in
            // TODO: scary
            WebSiteColor(from: decoded)!
        })
    }

    deinit {
        self.defaults?.set(self.websites.map({ ws in try? ws.encode() }), forKey: lastKnownExtensionStateKey)
    }

    public func add() {
        self.websites.append(WebSiteColor(host: "", hexColor: "#\(self.randomHextString(length: 6))"))
    }

    func randomHextString(length: Int) -> String {
        let symbols = "0123456789abcdef"
        return String((0 ..< length).map{ _ in symbols.randomElement()! })
    }
}
