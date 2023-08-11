//
//  DiceView.swift
//  HighRollers
//
//  Created by Felipe Casalecchi on 11/08/23.
//

import SwiftUI

struct DiceView: View {
    @State private var number = 6
    @State private var maxNumber = 6
    
    var body: some View {
        VStack {
            Text("\(number)")
                .font(.system(size: 150))
                .foregroundColor(.white)
                .frame(width: 300, height: 300)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.cyan.opacity(0.7))
                        .shadow(radius: 40)
                )
                .padding()
                .onTapGesture {
                    number = Int.random(in: 1...maxNumber)
                }
        }
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView()
    }
}
