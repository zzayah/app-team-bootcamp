//
//  ContentView.swift
//  FriskyFood
//
//  Created by Zayah Cortright on 11/12/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showMainApp = false
    @State private var showInstructions = false
    var body: some View {

        ZStack {
            if showMainApp {
                TabView {
                    NavigationStack {
                        RecipeSearchView()
                    }
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                    
                    
                    NavigationStack {
                        FavoritesView()
                    }
                    .tabItem {
                        Label("Favorites", systemImage: "heart.fill")
                    }
                }
                .accentColor(.orange)
                .onAppear {
                    UINavigationBar.appearance().tintColor = UIColor.orange
                }
            } else if showInstructions {
                
                RulesView(showMainApp: $showMainApp)
                
            } else {
                
                OnboardingView(showInstructions: $showInstructions)
                
            }
            
        }
        .animation(.easeInOut(duration: 1.0), value: showMainApp)
        .animation(.easeInOut(duration:2.0), value: showInstructions)
        
    }
}

struct RulesView: View {
    @Binding var showMainApp: Bool
    
    var body: some View {
        
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [
                    .white,
                    .white,
                    .orange.opacity(0.2),
                    .orange.opacity(0.4)
                ]),
                center: .center,
                startRadius: 50,
                endRadius: 500
            )
            .ignoresSafeArea()
            .contentShape(Rectangle())
            .onTapGesture {
                showMainApp = true
            }
            
            VStack() {
                Text("How to Use")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.orange)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.orange.opacity(0.03))
                        .background(.ultraThinMaterial)
                        .cornerRadius(16)
                        .blur(radius: 2)
                        .frame(height: 350)
                        .padding(.horizontal, 10)
                    VStack(alignment: .leading, spacing: 15) {
                        Text("1. Pick a category (breakfast, dessert, etc.) or hit Random to get surprised")
                        Text("2. We'll pull up one random recipe from that category")
                        Text("3. Tap the recipe card to see the full instructions and ingredients")
                        Text("4. Like what you see? Hit the heart to save it to your favorites")
                        Text("5. That's literally it. no searching, no scrolling through a million options, just easy recipes when you need them")
                    }
                    .padding(.horizontal, 20)
                    
                }
                
                
            


            }
        }
        
        
        
    }
    
}

struct OnboardingView: View {
    @Binding var showInstructions: Bool
    @State private var animate = false
    
    var body: some View {
        ZStack{
            
            RadialGradient(
                gradient: Gradient(colors: [
                    .white,
                    .white,
                    .orange.opacity(animate ? 0.4 : 0.1),
                    .orange.opacity(animate ? 0.6 : 0.2)
                ]),
                center: .center,
                startRadius: animate ? 100 : 50,
                endRadius: animate ? 600 : 400
            )
            .ignoresSafeArea()
            .contentShape(Rectangle())
            .onTapGesture {
                showInstructions = true
            }
            
            VStack {
                
                HStack(spacing: 10) {
                    Text("Get")
                    Text(" Frisky")
                        .font(.title)
                        .foregroundColor(.orange)
                    Text(" With ")
                    Text("FriskyFoods")
                        .font(.title)
                        
//                        .background(.orange)
//                        .foregroundColor(.white)
                        .foregroundColor(.orange)
                        .bold()
                        .cornerRadius(4)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 50)
                .scaleEffect(animate ? 1.05 : 1.0)

                
                Text("Tap Anywhere to Begin")
                    .foregroundColor(.orange)
                
            }
            
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                animate = true
            }
        }
    }
}


#Preview {
    ContentView()
        .environmentObject(FavoritesViewModel())
}
