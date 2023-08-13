//
//  HistoryView.swift
//  HighRollers
//
//  Created by Felipe Casalecchi on 11/08/23.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var rolls: Rolls
    
    var body: some View {
        if rolls.history.isEmpty {
            Text("Roll the dice!")
                .font(.largeTitle)
                .foregroundColor(.cyan)
        } else {
            List {
                ForEach(rolls.history) { roll in
                    VStack {
                        Text("\(roll.number) out of \(roll.diceFaces)")
                            .font(.largeTitle)
                        
                        Text("\(roll.time.formatted(date: .abbreviated, time: .shortened))")
                            .font(.caption)
                    }
                    .swipeActions {
                        Button {
                            rolls.delete(roll)
                        } label: {
                            Image(systemName: "trash")
                                .tint(.red)
                        }
                    }
                }
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .environmentObject(Rolls())
    }
}
