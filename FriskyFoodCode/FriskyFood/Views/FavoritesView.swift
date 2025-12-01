//
//  ContentView.swift
//  FriskyFood
//
//  Created by Zayah Cortright on 11/12/25.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favorites: FavoritesViewModel
    @State private var searchText = ""
    
    private var filteredFavorites: [Recipe] {
            if searchText.isEmpty {
                return favorites.favorites
            } else {
                return favorites.favorites.filter { recipe in
                    recipe.name.localizedCaseInsensitiveContains(searchText)
                }
            }
        }

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
            
            VStack {

//                Text("Favorites")
//                    .font(.largeTitle)
//                    .bold()
//                    .foregroundColor(.orange)
//                    .padding(.top, 20)
//                    .padding(.bottom, 10)
                
                
                List {
                    ForEach(filteredFavorites) { recipe in
                        NavigationLink(value: recipe) {
                            RecipeRowView(recipe: recipe)
                        }
                        .listRowBackground(Color.clear)
                        .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
                    }
                    .onDelete { favorites.favorites.remove(atOffsets: $0) }
                }
                .scrollContentBackground(.hidden)
                .background(Color.clear)
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Favorites")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.orange)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                }
            }
            .searchable(text: $searchText, prompt: "Search Favorites")
            .toolbarTitleDisplayMode(.inline)
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailView(recipe: recipe)
                
            }
        }
            
    }
}

#Preview {
    NavigationStack {
        FavoritesView()
            .environmentObject(FavoritesViewModel())
    }
}
