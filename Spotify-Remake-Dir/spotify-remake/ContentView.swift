//
//  ContentView.swift
//  spotify-remake
//
//  Created by Zayah Cortright on 9/23/25.
//

import SwiftUI

struct ContentView: View {

    @State private var selectedTab: String = "Home"
    @State private var showPlayer: Bool = false
    @State private var sliderProgress: Double = 0.0

    private let tabs: [(icon: String, label: String)] = [
        (icon: "house.fill", label: "Home"),
        (icon: "magnifyingglass", label: "Search"),
        (icon: "book.fill", label: "Your Library"),
        (icon: "plus", label: "Create"),
    ]

    private let topTabs: [String] = ["All", "Music", "Podcasts", "Audiobooks"]

    var body: some View {

        ZStack {
            VStack {
                HStack {
                    Image("profile-picture")
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .contentShape(Circle())
                        .frame(width: 40, height: 40)
                        .padding(.trailing, 5)
                    Spacer()

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(topTabs, id: \.self) { topName in
                                Text(topName)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(12)
                                    .foregroundColor(.gray)
                            }
                        }
                    }

                }
                .padding(.horizontal, 15)
                .padding(.bottom, 15)
                .background(.black.opacity(0.9))

                Spacer()

                BottomView(
                    selectedTab: $selectedTab,
                    tabs: tabs,
                    showPlayer: $showPlayer
                )
                .frame(maxWidth: .infinity)
                .padding(15)
                .background(.black.opacity(0.9))
            }
            .background(.black)

            if showPlayer {
                PlayerView(
                    showPlayer: $showPlayer,
                    sliderProgress: $sliderProgress
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.black)
                .transition(.move(edge: .bottom))
                .zIndex(1)
            } else {
                Text("\(selectedTab)")
                    .foregroundColor(.white)
                    .bold()
            }
        }
        .animation(.easeInOut(duration: 0.3), value: showPlayer)
    }
}

struct BottomView: View {
    @Binding var selectedTab: String
    var tabs: [(icon: String, label: String)]
    @Binding var showPlayer: Bool

    var body: some View {
        HStack {
            ForEach(tabs, id: \.label) { tab in
                Button {
                    if tab.label == "Create" {
                        withAnimation { showPlayer = true }
                    } else {
                        withAnimation {
                            selectedTab = tab.label
                            showPlayer = false
                        }
                    }
                } label: {
                    VStack(spacing: 8) {
                        Image(systemName: tab.icon)
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(
                                selectedTab == tab.label ? .white : .gray
                            )
                        Text(tab.label)
                            .font(.caption)
                            .foregroundColor(
                                selectedTab == tab.label ? .white : .gray
                            )
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

struct PlayerView: View {
    @Binding var showPlayer: Bool
    @State private var isPlaying: Bool = false
    @Binding var sliderProgress: Double

    var body: some View {
        VStack {
            
            HStack {

                Button {
                    withAnimation { showPlayer = false }
                } label: {
                    HStack {
                        Image(systemName: "chevron.down")
                            .foregroundColor(.white)
                            .padding(.horizontal, 15)
                            .font(.system(size: 20, weight: .bold))
                    }

                }
                Spacer()

            }

            Text("Now Playing")
                .foregroundColor(.white)
                .bold()

            Spacer()

            Image("album-cover")
                .resizable()
                .scaledToFill()
                .frame(width: 350, height: 350)
                .clipShape(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                )
                .padding(.bottom, 20)

            Spacer()

            HStack {
                VStack(alignment: .leading) {
                    Text("3005")
                        .foregroundColor(.white)
                        .font(.system(size: 25, weight: .bold))
                    HStack {
                        Image(systemName: "e.square.fill")
                            .foregroundColor(.gray)
                        Text("Childish Gambino")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.leading, 15)

                Spacer()

                ZStack {
                    Circle()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white)
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.black)
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                }
                .padding(.trailing, 15)

            }
            .padding(.bottom, 10)

            HStack {
                Button {
                } label: {
                    Image(systemName: "shuffle")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white)
                }
                Spacer()
                Button {
                } label: {
                    Image(systemName: "backward.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 25)

                Button {
                    isPlaying.toggle()
                } label: {
                    Image(
                        systemName: isPlaying
                            ? "pause.circle.fill" : "play.circle.fill"
                    )
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.green)
                }

                Button {
                } label: {
                    Image(systemName: "forward.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 25)

                Spacer()
                Button {
                } label: {
                    Image(systemName: "repeat")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)

            Slider(value: $sliderProgress, in: 0...1)
                .accentColor(.green)
                .padding(.horizontal, 20)
                .padding(.bottom, 40)

            HStack {
                Image(systemName: "headphones")
                    .foregroundColor(.green)
                    .padding(.leading, 25)
                Text("Z's Airpods Pro")
                    .foregroundColor(.green)
                    .font(.system(size: 13, weight: .regular))
                Spacer()

                Image(systemName: "square.and.arrow.up")
                    .foregroundColor(.white)
                    .padding(.trailing, 5)

                Image(systemName: "tray")
                    .foregroundColor(.white)
                    .padding(.trailing, 25)

            }
        }
    }
}

#Preview {
    ContentView()
}

