//
//  ContentView.swift
//  HighRollers
//
//  Created by Felipe Casalecchi on 11/08/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DiceView()
                .tabItem {
                    Label("Roll!", systemImage: "dice")
                }
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "book")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
