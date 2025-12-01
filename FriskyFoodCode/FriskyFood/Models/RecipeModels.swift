//
//  RecipeModels.swift
//  FriskyFood
//
//  Created by Zayah Cortright on 11/30/25.
//

import Foundation

struct RecipeSearchResponse: Codable {
    let recipes: [Recipe]
    let total: Int
    let skip: Int
    let limit: Int
}

struct Recipe: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let instructions: [String]
    let ingredients: [String]
    let image: String
    let cuisine: String?
    let difficulty: String?
}
