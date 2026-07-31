//
//  Tile.swift
//  MahjNite
//
//  Created by Benjamin Guo on 7/13/26.
//
//  Tile defintion with suits and honors
//

import Foundation

enum Suit: Equatable, Hashable {
    case characters, bamboos, circles
}

enum Wind: Equatable, Hashable {
    case east, south, west, north
}

enum Dragon: Equatable, Hashable {
    case red, green, white
}

enum Honor: Equatable, Hashable {
    case wind(Wind)
    case dragon(Dragon)
}

enum Tile: Equatable, Hashable {
    case suit(suit: Suit, rank: Int)
    case honor(honor: Honor)
}

extension Tile {
    var sortValue: Int {
        switch self {
        case .suit(let suit, let rank):
            let suitOrder: Int
            switch suit {
            case .characters: suitOrder = 0
            case .bamboos: suitOrder = 1
            case .circles: suitOrder = 2
            }
            return suitOrder * 10 + rank
        case .honor(let honor):
            switch honor {
            case .wind(let wind):
                let windOrder: Int
                switch wind {
                case .east: windOrder = 0
                case .south: windOrder = 1
                case .west: windOrder = 2
                case .north: windOrder = 3
                }
                return 100 + windOrder
            case .dragon(let dragon):
                let dragonOrder: Int
                switch dragon {
                case .red: dragonOrder = 0
                case .green: dragonOrder = 1
                case .white: dragonOrder = 2
                }
                return 110 + dragonOrder
            }
        }
    }
}
