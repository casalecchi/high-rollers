//
//  Roll.swift
//  HighRollers
//
//  Created by Felipe Casalecchi on 12/08/23.
//

import Foundation

struct Roll: Equatable, Codable, Identifiable {
    let id: UUID
    let number: Int
    let diceFaces: Int
    let time: Date
    
    static func ==(lhs: Roll, rhs: Roll) -> Bool {
        lhs.id == rhs.id
    }
}

@MainActor class Rolls: ObservableObject {
    @Published private(set) var history: [Roll]
    let fileURL = FileManager.documentsDirectory.appendingPathComponent("history.json")
    
    init() {
        do {
            let data = try Data(contentsOf: fileURL)
            history = try JSONDecoder().decode([Roll].self, from: data)
        } catch {
            print("Could not load saved data: \(error.localizedDescription)")
            history = []
        }
    }
    
    func add(_ roll: Roll) {
        history.append(roll)
        save()
    }
    
    func delete(_ roll: Roll) {
        if let index = history.firstIndex(of: roll) {
            history.remove(at: index)
            save()
        }
    }
    
    private func save() {
        do {
            let encoded = try JSONEncoder().encode(history)
            try encoded.write(to: fileURL)
        } catch {
            print("Data could not be saved: \(error.localizedDescription)")
        }
    }
}
