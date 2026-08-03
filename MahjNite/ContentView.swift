//
//  ContentView.swift
//  MahjNite
//
//  Created by Benjamin Guo on 7/12/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var game = GameState()
    
    var body: some View {
        VStack {
            Spacer()
            DiscardPileView(tiles: game.discards)
            Spacer()
            Text("Your Hand (\(game.wall.count) tiles left in wall)")
                .font(.headline)
            HandView(tiles: game.hands[0], onTileTapped: { index in
                game.humanDiscard(at: index)
            })
            .padding(.bottom)
        }
        .alert("You Win! 🎉", isPresented: $game.showWinAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

#Preview {
    ContentView()
}
