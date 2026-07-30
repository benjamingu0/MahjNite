//
//  WinChecker.swift
//  MahjNite
//
//  Created by Benjamin Guo on 7/30/26.
//

import Foundation

func isWinningHand(_ tiles: [Tile]) -> Bool {
    guard tiles.count == 14 else { return false }
    
    let uniqueTiles = Set(tiles.map { TileKey($0) })
    
    for pairKey in uniqueTiles {
        var remaining = tiles
        var removedCount = 0
        
        remaining.removeAll { tile in
            if removedCount < 2 && TileKey(tile) == pairKey {
                removedCount += 1
                return true
            }
            return false
        }
        
        if removedCount == 2 && canFormSets(remaining) {
            return true
        }
    }
    
    return false
}

func canFormSets(_ tiles: [Tile]) -> Bool {
    if tiles.isEmpty { return true }
    
    var tiles = tiles
    let first = tiles.removeFirst()
    let matchingIndices = tiles.indices.filter { TileKey(tiles[$0]) == TileKey(first) }
    
    if matchingIndices.count >= 2 {
        var withoutPung = tiles
        withoutPung.remove(at: matchingIndices[1])
        withoutPung.remove(at: matchingIndices[0])
        if canFormSets(withoutPung) { return true }
    }
    
    if case .suit(let suit, let rank) = first, rank <= 7 {
        if let secondIndex = tiles.firstIndex(where: { TileKey($0) == TileKey(.suit(suit: suit, rank: rank + 1)) }),
           let thirdIndex = tiles.firstIndex(where: { TileKey($0) == TileKey(.suit(suit: suit, rank: rank + 2)) }) {
            var withoutChow = tiles
            let indices = [secondIndex, thirdIndex].sorted(by: >)
            for idx in indices {
                withoutChow.remove(at: idx)
            }
            if canFormSets(withoutChow) { return true }
        }
    }
    
    return false
}

struct TileKey: Hashable {
    let value: String
    
    init(_ tile: Tile) {
        switch tile {
        case .suit(let suit, let rank):
            value = "suit-\(suit)-\(rank)"
        case .honor(let honor):
            value = "honor-\(honor)"
        }
    }
}
