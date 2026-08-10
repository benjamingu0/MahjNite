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
            if !game.exposedSets[0].isEmpty {
                ExposedSetsView(sets: game.exposedSets[0])
            }
            Text("Your Hand (\(game.wall.count) tiles left in wall)")
                .font(.headline)
            HandView(tiles: game.hands[0], onTileTapped: { index in
                game.humanDiscard(at: index)
            })
            .padding(.bottom)
        }
        .alert("You Win!", isPresented: $game.showWinAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            if let result = game.winResult {
                Text("\(result.patterns.joined(separator: ", ")) — \(result.totalFan) fan")
            }
        }
        .alert(
            "Call Pung?",
            isPresented: Binding(
                get: { game.pendingPungTile != nil },
                set: { if !$0 { game.pendingPungTile = nil } }
            )
        ) {
            Button("Pung!") {
                game.confirmPung()
            }
            Button("Pass", role: .cancel) {
                game.declinePung()
            }
        }
        .alert(
            "Call Kong?",
            isPresented: Binding(
                get: { game.pendingKongTile != nil },
                set: { if !$0 { game.pendingKongTile = nil } }
            )
        ) {
            Button("Kong!") {
                game.confirmKong()
            }
            Button("Pass", role: .cancel) {
                game.declineKong()
            }
        }
        .alert(
            "Call Chow?",
            isPresented: Binding(
                get: { game.pendingChowTile != nil },
                set: { if !$0 { game.pendingChowTile = nil } }
            )
        ) {
            Button("Chow!") {
                game.confirmChow()
            }
            Button("Pass", role: .cancel) {
                game.declineChow()
            }
        }
    }
}

#Preview {
    ContentView()
}
