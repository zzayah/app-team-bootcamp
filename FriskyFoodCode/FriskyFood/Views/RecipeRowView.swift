//
//  RecipeRowView.swift
//  FriskyFood
//
//  Created by Zayah Cortright on 11/25/25.
//

import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: recipe.image)) { img in
                img.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                
                Text(recipe.cuisine ?? "Unknown cuisine")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 6)
    }
}
