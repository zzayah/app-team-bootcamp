//
//  ContentView.swift
//  instagram-static-page
//
//  Created by Zayah Cortright on 9/12/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Image("anotherwave")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                    .contentShape(Circle())
                Text("Green Earth")
                    .font(.system(size: 16, weight: .semibold))
                Text("•")
                    .font(.system(size: 16, weight: .semibold))
                Text("Follow")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.blue)
                Spacer()
                Image(systemName: "ellipsis")
                    .font(.system(size: 16, weight: .semibold))

            }
            .padding(.horizontal, 14)
            
            Image("waves")
                .resizable()
                .scaledToFit()
            
        .padding(.vertical, 4)
        .padding(.horizontal, 4)
            
            HStack(spacing: 10) {
                Image(systemName: "heart")
                    .resizable()
                    .frame(width:20, height:20)
                    .font(.system(size: 21, weight: .semibold))
                Text("823")
                    .font(.system(size: 16, weight: .semibold))
                Image(systemName: "bubble.left")
                    .resizable()
                    .frame(width:20, height:20)
                    .font(.system(size: 21, weight: .semibold))
                Text("72")
                    .font(.system(size: 16, weight: .semibold))
                Image(systemName: "paperplane")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .font(.system(size: 21, weight: .semibold))
                Text("9")
                    .font(.system(size: 16, weight: .semibold))

                Spacer()
                
                Image(systemName: "bookmark")
                    .resizable()
                    .frame(width: 15, height: 20)
                    .font(.system(size: 21, weight: .semibold))
            }
            .padding(.horizontal, 8)
            
        }
        HStack(spacing: 6) {
            Text("Green Earth")
                .font(.system(size: 14, weight: .bold))
            Text("First post! Drop a follow!")
                .font(.system(size: 14))
            Spacer()
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        
        
    }
}

#Preview {
    ContentView()
}
