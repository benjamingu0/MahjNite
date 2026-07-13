//
//  Tile.swift
//  MahjNite
//
//  Created by Benjamin Guo on 7/13/26.
//
//  Tile defintion with suits and honors
//

import Foundation

enum Suit: Equatable {
    case characters, bamboos, circles
}

enum Wind: Equatable {
    case east, south, west, north
}

enum Dragon: Equatable {
    case red, green, white
}

enum Honor: Equatable {
    case wind(Wind)
    case dragon(Dragon)
}

enum Tile: Equatable {
    case suit(suit: Suit, rank: Int)
    case honor(honor: Honor)
}
