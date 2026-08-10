//
//  ScoringEngine.swift
//  MahjNite
//
//  Created by Benjamin Guo on 8/10/26.
//

import Foundation

import Foundation

struct ScoredHand {
    let patterns: [String]
    let totalFan: Int
}

func scoreHand(concealedTiles: [Tile], exposedSets: [[Tile]]) -> ScoredHand {
    let allTiles = concealedTiles + exposedSets.flatMap { $0 }

    var patterns: [String] = []
    var totalFan = 0

    if isAllSimples(allTiles) {
        patterns.append("All Simples")
        totalFan += 1
    }

    if isAllPungs(exposedSets: exposedSets, concealedTiles: concealedTiles) {
        patterns.append("All Pungs")
        totalFan += 3
    }

    if let flushResult = flushType(allTiles) {
        patterns.append(flushResult.name)
        totalFan += flushResult.fan
    }

    return ScoredHand(patterns: patterns, totalFan: totalFan)
}

func isAllSimples(_ tiles: [Tile]) -> Bool {
    for tile in tiles {
        switch tile {
        case .suit(_, let rank):
            if rank == 1 || rank == 9 { return false }
        case .honor:
            return false
        }
    }
    return true
}

func isAllPungs(exposedSets: [[Tile]], concealedTiles: [Tile]) -> Bool {
    for set in exposedSets {
        if set.count == 3 || set.count == 4 {
            let allSame = set.allSatisfy { TileKey($0) == TileKey(set[0]) }
            if !allSame { return false }
        }
    }
    return true
}

func flushType(_ tiles: [Tile]) -> (name: String, fan: Int)? {
    var suits = Set<Suit>()
    var hasHonor = false

    for tile in tiles {
        switch tile {
        case .suit(let suit, _):
            suits.insert(suit)
        case .honor:
            hasHonor = true
        }
    }

    guard suits.count == 1 else { return nil }

    if hasHonor {
        return ("Half Flush", 3)
    } else {
        return ("Full Flush", 7)
    }
}
