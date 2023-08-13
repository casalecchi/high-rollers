//
//  ContentView.swift
//  HighRollers
//
//  Created by Felipe Casalecchi on 11/08/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var rolls = Rolls()
    @StateObject var diceSettings = DiceSettings()
    
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
            ConfigurationView()
                .tabItem {
                    Label("Info & Settings", systemImage: "gearshape.fill")
                }
        }
        .environmentObject(rolls)
        .environmentObject(diceSettings)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
