//
//  RecipeViewModel.swift
//  FriskyFood
//
//  Created by Zayah Cortright on 11/27/25.
//

import Foundation

// Recieved a lot of help to get this working

@MainActor
class RecipeSearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var recipes: [Recipe] = []
    @Published var errorMessage: String?

    private let service = RecipeService()

    // regular search
    func search() {
        errorMessage = nil

        Task {
            do {
                let result = try await service.searchRecipes(query: query)
                recipes = result.recipes
            } catch {
                errorMessage = "issue in search() function; RecipeSearchModel"
            }
        }
    }
    
    // search by category and pick random one
    func searchByCategory(_ category: String) {
        errorMessage = nil

        Task {
            do {
                let result = try await service.searchRecipes(query: category)
                // grab one random recipe from the category
                if let randomRecipe = result.recipes.randomElement() {
                    recipes = [randomRecipe]
                } else {
                    recipes = []
                }
            } catch {
                errorMessage = "issue in searchByCategory() function; RecipeSearchModel"
            }
        }
    }
    
    // fully random recipe from all categories
    func getRandomRecipe() {
        let categories = ["Pizza","Italian","Vegetarian","Mexican","Thai","Moroccan","Japanese","Greek"]
        let randomCategory = categories.randomElement() ?? "Dessert"
        searchByCategory(randomCategory)
    }
}

