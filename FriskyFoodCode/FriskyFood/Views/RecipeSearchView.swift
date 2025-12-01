//
//  ContentView.swift
//  FriskyFood
//
//  Created by Zayah Cortright on 11/30/25.
//

import SwiftUI

struct RecipeSearchView: View {
    @StateObject private var vm = RecipeSearchViewModel()
    @EnvironmentObject var favorites: FavoritesViewModel
    
    // FlowLayout stuff
    @State private var align = VerticalAlignment.bottom
    private let paddings: [Int] = [35, 40, 15, 40, 20, 30, 35, 40]
    private let categories: [String] = ["Pizza","Italian","Vegetarian","Mexican","Thai","Moroccan","Japanese","Greek"]


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
                Text("Roll the Dice")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.orange)
                    .padding(.top, 20)
                        .padding(.bottom, 10)
                VStack {
                    // category buttons via FlowLayout...
                    let layout = FlowLayout(alignment: align)
                    layout {
                        ForEach(paddings.indices, id: \.self) { i in
                            Button {
                                vm.searchByCategory(categories[i])
                            } label: {
                                Text(categories[i])
                                    .padding(CGFloat(paddings[i]))
                                    .background(.orange)
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
                    // random button
                    Button("Random?") {
                        vm.getRandomRecipe()
                    }
                    .frame(maxWidth: .infinity, minHeight: 80)
                    .background(.orange)
                    .foregroundColor(.white)
                    .bold()
                    .cornerRadius(16)
                    .padding(.horizontal, 10)
                }
                
                // single recipe result
                VStack {
                    if let error = vm.errorMessage { Text(error).foregroundColor(.red) }

                    if let recipe = vm.recipes.first {
                        NavigationLink(value: recipe) {
                            RecipeRowView(recipe: recipe)
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(12)
                                .padding(.horizontal)
                        }
                    }
                }
                
                Spacer()
            }
        }
        .navigationDestination(for: Recipe.self) { recipe in
            RecipeDetailView(recipe: recipe)
        }
    }
}

//#Preview {
//    RecipeSearchView()
//        .environmentObject(FavoritesViewModel())
//}
