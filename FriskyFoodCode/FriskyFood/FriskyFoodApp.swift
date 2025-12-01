//
//  FriskyFoodApp.swift
//  FriskyFood
//
//  Created by Zayah Cortright on 11/30/25.
//

import SwiftUI

@main
struct FriskyFoodApp: App {
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favoritesViewModel)
        }
    }
}
