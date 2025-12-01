//
//  RecipeDetailView.swift
//  FriskyFood
//
//  Created by Zayah Cortright on 11/25/25.
//

import SwiftUI

struct RecipeDetailView: View {
    @EnvironmentObject var favorites: FavoritesViewModel
    let recipe: Recipe
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [
                    Color.white,
                    Color.white,
                    Color.orange.opacity(0.2),
                    Color.orange.opacity(0.4)
                ]),
                center: .center,
                startRadius: 50,
                endRadius: 500
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    AsyncImage(url: URL(string: recipe.image)) { img in
                        img.resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity)
                    .cornerRadius(12)
                    
                    HStack {
                        Text(recipe.name)
                            .font(.title)
                            .bold()
                        
                        Spacer()
                        
                        Button {
                            favorites.toggleFavorite(recipe)
                        } label: {
                            Image(systemName: favorites.isFavorite(recipe) ? "heart.fill" : "heart")
                                .font(.title2)
                                .foregroundStyle(.red)
                        }
                    }
                    
                    if let cuisine = recipe.cuisine {
                        Label(cuisine, systemImage: "globe")
                    }
                    
                    if let difficulty = recipe.difficulty {
                        Label("Difficulty: \(difficulty)", systemImage: "chart.bar.fill")
                    }
                    
                    Divider()
                    
                    Text("Ingredients")
                        .font(.headline)
                    ForEach(recipe.ingredients, id: \.self) { item in
                        Text("• \(item)")
                    }
                    
                    Divider()
                    
                    Text("Instructions")
                        .font(.headline)
                    ForEach(recipe.instructions.indices, id: \.self) { i in
                        Text("\(i+1). \(recipe.instructions[i])")
                            .padding(.bottom, 4)
                    }
                }
                .padding()
            }
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
