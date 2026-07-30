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
