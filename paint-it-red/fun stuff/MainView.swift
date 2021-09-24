//
//  MainView.swift
//  paint-it-red
//
//  Created by Kukushkin, Vladimir on 24.9.2021.
//

import Foundation
import SwiftUI

struct MainView: View {
    @StateObject var viewModel: ViewModel = ViewModel()

    func add() {
        self.viewModel.add()
    }

    func delete(at offsets: IndexSet) {
        self.viewModel.websites.remove(atOffsets: offsets)
    }

    var body: some View {
        // TODO: a bug with removing last item?
        if self.viewModel.websites.count < 1 {
            HStack {
                Text("No color options, add some!")
                Button(action: add) { Label("", systemImage: "plus") }
            }
        }
        else {
            NavigationView {
                List {
                    ForEach(self.viewModel.websites, id: \.id) { ws in
                        HStack {
                            if let index = self.viewModel.websites.firstIndex(of: ws) {
                                RuleView(ws: self.$viewModel.websites[index])
                            }
                         }
                    }
                    .onDelete(perform: delete)
                }
                .toolbar {
                    HStack {
                        Button(action: add) { Label("", systemImage: "plus") }
                        EditButton()
                    }
                }
            }
        }
    }
}
