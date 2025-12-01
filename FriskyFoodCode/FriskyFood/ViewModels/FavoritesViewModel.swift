//
//  FavoritesViewModel.swift
//  FriskyFood
//
//  Created by Zayah Cortright on 11/27/25.
//

import Foundation

// Recieved a lot of help to get this working

@MainActor
class FavoritesViewModel: ObservableObject {
    @Published var favorites: [Recipe] = []
    
    func toggleFavorite(_ recipe: Recipe) {
        
        // Check if it already exists by ID
        if favorites.contains(where: { $0.id == recipe.id }) {
            
            // Remove that recipe
            favorites.removeAll { $0.id == recipe.id }
            
        } else {
            
            // Add it
            favorites.append(recipe)
        }
    }
    
    func isFavorite(_ recipe: Recipe) -> Bool {
        favorites.contains(recipe)
    }
}
