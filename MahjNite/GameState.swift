//
//  GameState.swift
//  MahjNite
//
//  Created by Benjamin Guo on 8/3/26.
//

import Foundation
import Combine

class GameState: ObservableObject {
    @Published var hands: [[Tile]] = [[], [], [], []]
    @Published var exposedSets: [[[Tile]]] = [[], [], [], []]
    @Published var wall: [Tile] = []
    @Published var discards: [Tile] = []
    @Published var currentPlayer: Int = 0
    @Published var showWinAlert = false

    @Published var pendingPungTile: Tile? = nil
    private var pendingPungDiscarder: Int? = nil

    init() {
        let fullWall = generateWall()
        var remaining = fullWall

        for i in 0..<4 {
            let dealt = Array(remaining.prefix(13))
            hands[i] = dealt.sorted { $0.sortValue < $1.sortValue }
            remaining.removeFirst(13)
        }

        wall = remaining
    }

    func humanDiscard(at tileIndex: Int) {
        guard currentPlayer == 0 else { return }

        let tile = hands[0].remove(at: tileIndex)
        discards.append(tile)

        for botIndex in 1...3 {
            if canCallPung(tile: tile, player: botIndex) {
                print("Bot \(botIndex) could pung \(tile)!")
            }
        }

        advanceTurn()
    }

    func confirmPung() {
        guard let tile = pendingPungTile, let discarder = pendingPungDiscarder else { return }

        var removed = 0
        hands[0].removeAll { t in
            if removed < 2 && TileKey(t) == TileKey(tile) {
                removed += 1
                return true
            }
            return false
        }

        if let lastIndex = discards.lastIndex(where: { TileKey($0) == TileKey(tile) }) {
            discards.remove(at: lastIndex)
        }

        exposedSets[0].append([tile, tile, tile])

        pendingPungTile = nil
        pendingPungDiscarder = nil

        currentPlayer = 0
    }

    func declinePung() {
        let discarder = pendingPungDiscarder
        pendingPungTile = nil
        pendingPungDiscarder = nil

        currentPlayer = discarder ?? currentPlayer
        advanceTurn()
    }

    private func advanceTurn() {
        currentPlayer = (currentPlayer + 1) % 4

        if currentPlayer == 0 {
            if !wall.isEmpty {
                hands[0].append(wall.removeFirst())
                hands[0].sort { $0.sortValue < $1.sortValue }
                if isWinningHand(hands[0]) {
                    showWinAlert = true
                }
            }
        } else {
            botPlay()
        }
    }

    private func botPlay() {
        guard !wall.isEmpty else { return }

        hands[currentPlayer].append(wall.removeFirst())

        let discardIndex = Int.random(in: 0..<hands[currentPlayer].count)
        let tile = hands[currentPlayer].remove(at: discardIndex)
        discards.append(tile)

        if canCallPung(tile: tile, player: 0) {
            pendingPungTile = tile
            pendingPungDiscarder = currentPlayer
        } else {
            advanceTurn()
        }
    }

    func canCallPung(tile: Tile, player: Int) -> Bool {
        let matchingCount = hands[player].filter { TileKey($0) == TileKey(tile) }.count
        return matchingCount >= 2
    }
}
