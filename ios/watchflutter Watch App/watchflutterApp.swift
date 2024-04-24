//
//  watchflutterApp.swift
//  watchflutter Watch App
//
//  Created by Leandro Pontes Berleze on 23/04/24.
//

import SwiftUI

@main
struct WatchFlutterApp: App {
    var body: some Scene {
        return WindowGroup {
            CounterView(viewModel: CounterViewModel())
        }
    }
}
