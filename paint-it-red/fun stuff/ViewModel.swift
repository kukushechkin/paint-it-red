//
//  ViewModel.swift
//  paint-it-red
//
//  Created by Kukushkin, Vladimir on 24.9.2021.
//

import Foundation
import Combine

let lastKnownExtensionSettingsKey = "lastKnownExtensionSettings"

class ViewModel: ObservableObject {
    @Published var websites: [WebSiteColor] = []
    private let defaults = UserDefaults(suiteName: "group.AC5986BBE6.com.kukushechkin.PaintItRed.appGroup")

    public init() {
        self.websites = (self.defaults?.object(forKey: lastKnownExtensionSettingsKey) as? [Any] ?? []).map({ decoded in
            // TODO: scary
            WebSiteColor(from: decoded)!
        })
        self.observeItems(propertyToObserve: self.$websites)
    }

    // https://stackoverflow.com/questions/63479425/observing-a-published-var-from-another-object
    var itemObserver: AnyCancellable?
    func observeItems<P: Publisher>(propertyToObserve: P) where P.Output == [WebSiteColor], P.Failure == Never {
       itemObserver = propertyToObserve
            .throttle(for: 0.5, scheduler: RunLoop.main, latest: true)
            .sink {_ in
                // os_log(.debug, log: self.log, "observed settings update")
                self.updateSettings()
            }
    }

    func updateSettings() {
        self.defaults?.set(self.websites.map({ ws in try? ws.encode() }), forKey: lastKnownExtensionSettingsKey)
    }

    public func add() {
        self.websites.append(WebSiteColor(host: "", hexColor: "#\(self.randomHextString(length: 6))"))
    }

    func randomHextString(length: Int) -> String {
        let symbols = "0123456789abcdef"
        return String((0 ..< length).map{ _ in symbols.randomElement()! })
    }
}
