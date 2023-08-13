//
//  DiceView.swift
//  HighRollers
//
//  Created by Felipe Casalecchi on 11/08/23.
//

import CoreHaptics
import SwiftUI

struct DiceView: View {
    @EnvironmentObject var rolls: Rolls
    @EnvironmentObject var diceSettings: DiceSettings
    
    @State private var number = 6
    @State private var maxNumber = 6
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        VStack {
            Text("\(number)")
                .font(.system(size: 150))
                .foregroundColor(.secondary)
                .frame(width: 300, height: 300)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.cyan.opacity(0.7))
                        .shadow(radius: 40)
                )
                .padding()
                .onTapGesture {
                    rollDice()
                    number = Int.random(in: 1...maxNumber)
                    let roll = Roll(id: UUID(), number: number, diceFaces: maxNumber, time: Date.now)
                    rolls.add(roll)
                }
                .onAppear {
                    prepareHaptics()
                    maxNumber = diceSettings.diceSides
                }
        }
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Could not create the engine: \(error.localizedDescription)")
        }
    }
    
    func rollDice() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }

        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView()
            .environmentObject(Rolls())
            .environmentObject(DiceSettings())
    }
}
