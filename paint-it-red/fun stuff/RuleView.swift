//
//  RuleView.swift
//  paint-it-red
//
//  Created by Kukushkin, Vladimir on 24.9.2021.
//

import Foundation
import SwiftUI

struct RuleView: View {
    @Binding var ws: WebSiteColor
    @State var selectedColor: Color = .accentColor

    init(ws: Binding<WebSiteColor>) {
        self._ws = ws
        self._selectedColor = .init(initialValue: Color(hex: ws.hexColor.wrappedValue))
    }

    func onChange(color: Color) {
        ws.hexColor = self.selectedColor.hex
    }

    var body: some View {
        HStack {
            // TODO: background color
            TextField("e.g. apple.com", text: $ws.host, onCommit: {
                //
            })
                .textInputAutocapitalization(.never)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            ColorPicker("", selection: self.$selectedColor.onChange(onChange))
        }
    }
}
