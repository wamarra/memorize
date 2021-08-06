//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Wesley Marra on 06/08/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: EmojiMemoryGame())
        }
    }
}
