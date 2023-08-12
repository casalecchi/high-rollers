//
//  Roll.swift
//  HighRollers
//
//  Created by Felipe Casalecchi on 12/08/23.
//

import Foundation

struct Roll: Codable {
    let id: UUID
    let number: Int
    let diceFaces: Int
    let time: Date
}

@MainActor class Rolls: ObservableObject {
    @Published private(set) var rolls: [Roll]
    let fileURL = FileManager.documentsDirectory.appendingPathComponent("history.json")
    
    init() {
        do {
            let data = try Data(contentsOf: fileURL)
            rolls = try JSONDecoder().decode([Roll].self, from: data)
        } catch {
            print("Could not load saved data: \(error.localizedDescription)")
            rolls = []
        }
    }
    
    func add(_ roll: Roll) {
        rolls.append(roll)
        save()
    }
    
    private func save() {
        do {
            let encoded = try JSONEncoder().encode(rolls)
            try encoded.write(to: fileURL)
        } catch {
            print("Data could not be saved: \(error.localizedDescription)")
        }
    }
}
