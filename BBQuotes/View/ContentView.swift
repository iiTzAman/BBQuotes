//
//  ContentView.swift
//  BBQuotes
//
//  Created by Aman Giri on 2024-04-08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            QuoteView(show: "Breaking Bad")
                .tabItem {
                    Label("Breaking Bad", systemImage: "tortoise")

                }
            QuoteView(show: "Better Call Saul")
                .tabItem {
                    Label("Better Call Saul", systemImage: "briefcase")
                }
        }
        .onAppear{
            UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
        }
        
    }
}

#Preview {
    ContentView()
}
