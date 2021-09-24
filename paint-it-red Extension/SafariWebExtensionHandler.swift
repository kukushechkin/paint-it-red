//
//  SafariWebExtensionHandler.swift
//  paint-it-red Extension
//
//  Created by Kukushkin, Vladimir on 24.9.2021.
//

import SafariServices
import os.log
import Combine

let lastKnownExtensionSettingsKey = "lastKnownExtensionSettings"

class SafariWebExtensionHandler: NSObject, NSExtensionRequestHandling {

    private let defaults = UserDefaults(suiteName: "group.AC5986BBE6.com.kukushechkin.PaintItRed.appGroup")

    func beginRequest(with context: NSExtensionContext) {
        // fetch settings from the shared user defaults
        var settings: [WebSiteColor] = []
        guard let defaults = self.defaults else {
            os_log(.default, "No settings")
            return
        }
        if let objects = defaults.object(forKey: lastKnownExtensionSettingsKey) as? [Any] {
            settings = objects.map { WebSiteColor(from: $0)! }
        }

        if settings.count == 0 {
            os_log(.default, "No settings")
            return
        }

        let item = context.inputItems[0] as! NSExtensionItem
        let message = item.userInfo?[SFExtensionMessageKey]
        let messageDictionary = message as? [String: String]
        os_log(.default, "Received message from browser.runtime.sendNativeMessage: %@", message as! CVarArg)

        let response = NSExtensionItem()
        if let host = messageDictionary?["host"] {
            settings.forEach { ws in
                if host.contains(ws.host) {
                    response.userInfo = [ SFExtensionMessageKey: [ "theme-color": ws.hexColor ] ]
                }
            }
        }
        context.completeRequest(returningItems: [response], completionHandler: nil)
    }

}
