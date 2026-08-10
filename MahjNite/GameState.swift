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
    @Published var winResult: ScoredHand? = nil

    @Published var pendingPungTile: Tile? = nil
    private var pendingPungDiscarder: Int? = nil
    
    @Published var pendingKongTile: Tile? = nil
    private var pendingKongDiscarder: Int? = nil
    
    @Published var pendingChowTile: Tile? = nil
    private var pendingChowDiscarder: Int? = nil

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
    
    func confirmKong() {
        guard let tile = pendingKongTile, let discarder = pendingKongDiscarder else { return }

        var removed = 0
        hands[0].removeAll { t in
            if removed < 3 && TileKey(t) == TileKey(tile) {
                removed += 1
                return true
            }
            return false
        }

        if let lastIndex = discards.lastIndex(where: { TileKey($0) == TileKey(tile) }) {
            discards.remove(at: lastIndex)
        }

        exposedSets[0].append([tile, tile, tile, tile])

        pendingKongTile = nil
        pendingKongDiscarder = nil

        if !wall.isEmpty {
            hands[0].append(wall.removeFirst())
            hands[0].sort { $0.sortValue < $1.sortValue }
        }

        currentPlayer = 0
    }

    func declineKong() {
        let discarder = pendingKongDiscarder
        pendingKongTile = nil
        pendingKongDiscarder = nil

        currentPlayer = discarder ?? currentPlayer
        advanceTurn()
    }
    
    func confirmChow() {
        guard let tile = pendingChowTile, let needed = chowTiles(for: tile) else { return }

        for n in needed {
            if let idx = hands[0].firstIndex(where: { TileKey($0) == TileKey(n) }) {
                hands[0].remove(at: idx)
            }
        }

        if let lastIndex = discards.lastIndex(where: { TileKey($0) == TileKey(tile) }) {
            discards.remove(at: lastIndex)
        }

        exposedSets[0].append([tile] + needed)

        pendingChowTile = nil
        pendingChowDiscarder = nil

        currentPlayer = 0
    }

    func declineChow() {
        let discarder = pendingChowDiscarder
        pendingChowTile = nil
        pendingChowDiscarder = nil

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
                    winResult = scoreHand(concealedTiles: hands[0], exposedSets: exposedSets[0])
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

        if canCallKong(tile: tile, player: 0) {
            pendingKongTile = tile
            pendingKongDiscarder = currentPlayer
        } else if canCallPung(tile: tile, player: 0) {
            pendingPungTile = tile
            pendingPungDiscarder = currentPlayer
        } else if canCallChow(tile: tile, from: currentPlayer) {
            pendingChowTile = tile
            pendingChowDiscarder = currentPlayer
        } else {
            advanceTurn()
        }
    }

    func canCallPung(tile: Tile, player: Int) -> Bool {
        let matchingCount = hands[player].filter { TileKey($0) == TileKey(tile) }.count
        return matchingCount >= 2
    }
    
    func canCallKong(tile: Tile, player: Int) -> Bool {
        let matchingCount = hands[player].filter { TileKey($0) == TileKey(tile) }.count
        return matchingCount >= 3
    }
    
    func canCallChow(tile: Tile, from discarder: Int) -> Bool {
        guard discarder == 3 else { return false }
        guard case .suit(let suit, let rank) = tile else { return false }

        let combos: [[Int]] = [[rank - 2, rank - 1], [rank - 1, rank + 1], [rank + 1, rank + 2]]

        for combo in combos {
            guard combo[0] >= 1, combo[0] <= 9, combo[1] >= 1, combo[1] <= 9 else { continue }
            let needed = combo.map { Tile.suit(suit: suit, rank: $0) }
            let hasFirst = hands[0].contains { TileKey($0) == TileKey(needed[0]) }
            let hasSecond = hands[0].contains { TileKey($0) == TileKey(needed[1]) }
            if hasFirst && hasSecond {
                return true
            }
        }

        return false
    }

    func chowTiles(for tile: Tile) -> [Tile]? {
        guard case .suit(let suit, let rank) = tile else { return nil }

        let combos: [[Int]] = [[rank - 2, rank - 1], [rank - 1, rank + 1], [rank + 1, rank + 2]]

        for combo in combos {
            guard combo[0] >= 1, combo[0] <= 9, combo[1] >= 1, combo[1] <= 9 else { continue }
            let needed = combo.map { Tile.suit(suit: suit, rank: $0) }
            let hasFirst = hands[0].contains { TileKey($0) == TileKey(needed[0]) }
            let hasSecond = hands[0].contains { TileKey($0) == TileKey(needed[1]) }
            if hasFirst && hasSecond {
                return needed
            }
        }

        return nil
    }
}
