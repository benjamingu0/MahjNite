//
//  Wall.swift
//  MahjNite
//
//  Created by Benjamin Guo on 7/13/26.
//
//  Creates the tile wall
//

import Foundation

func generateWall() -> [Tile] {
    var tiles: [Tile] = []
    let suits: [Suit] = [.characters, .bamboos, .circles]
    let winds: [Wind] = [.east, .south, .west, .north]
    let dragons: [Dragon] = [.red, .green, .white]
    
    for suit in suits {
        for rank in 1...9 {
            for i in 1...4 {
                tiles.append(.suit(suit: suit, rank: rank))
            }
        }
    }
    for wind in winds {
        for i in 1...4 {
            tiles.append(.honor(honor: .wind(wind)))
        }
    }
    for dragon in dragons {
        for i in 1...4 {
            tiles.append(.honor(honor: .dragon(dragon)))
        }
    }
    
    return tiles.shuffled()
}
