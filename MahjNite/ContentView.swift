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
        ZStack {
            Color(red: 0.99, green: 0.97, blue: 0.94)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Text(game.currentPlayerName.uppercased())
                    .font(.system(size: 12, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(game.currentPlayer == 0 ? Color(red: 0.24, green: 0.60, blue: 0.44) : Color(red: 0.11, green: 0.16, blue: 0.29))
                    )
                Spacer()
                DiscardPileView(tiles: game.discards)
                Spacer()
                if !game.exposedSets[0].isEmpty {
                    ExposedSetsView(sets: game.exposedSets[0])
                }
                Text("YOUR HAND · \(game.wall.count) LEFT")
                    .font(.system(size: 13, weight: .heavy, design: .rounded))
                    .foregroundColor(Color(red: 0.11, green: 0.16, blue: 0.29))
                    .tracking(1)
                HandView(tiles: game.hands[0], onTileTapped: { index in
                    game.humanDiscard(at: index)
                })
                .padding(.bottom)
            }
        }
        .alert("You Win!", isPresented: $game.showWinAlert) {
            Button("New Game") {
                game.newGame()
            }
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
        .alert("It's a Draw", isPresented: $game.isDraw) {
            Button("New Game") {
                game.newGame()
            }
        }
    }
}

#Preview {
    ContentView()
}
