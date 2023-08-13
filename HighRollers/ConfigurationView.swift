//
//  ConfigurationView.swift
//  HighRollers
//
//  Created by Felipe Casalecchi on 12/08/23.
//

import SwiftUI

struct ConfigurationView: View {
    @EnvironmentObject var diceSettings: DiceSettings
    let sides = [4, 6, 8, 10, 12, 20, 100]
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Info")
                
                HStack {
                    Text("Dice sides:")
                    Picker("Please select the number of sides of your dice", selection: $diceSettings.diceSides) {
                        ForEach(sides, id: \.self) { side in
                            Text("\(side)")
                        }
                    }
                }
            }
            .navigationTitle("High Rollers!")
        }
    }
}

struct ConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationView()
            .environmentObject(DiceSettings())
    }
}
