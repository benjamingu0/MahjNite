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
    @Published var wall: [Tile] = []
    @Published var discards: [Tile] = []
    @Published var currentPlayer: Int = 0
    @Published var showWinAlert = false
    
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
    
    func humanDiscard(at index: Int) {
        guard currentPlayer == 0 else { return }
        
        let tile = hands[0].remove(at: index)
        discards.append(tile)
        
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
        
        advanceTurn()
    }
}
