//
//  ContentView.swift
//  MahjNite
//
//  Created by Benjamin Guo on 7/12/26.
//

import SwiftUI

struct ContentView: View {
    @State private var hand: [Tile]
    @State private var wall: [Tile]
    @State private var discards: [Tile] = []
    
    init() {
        let fullWall = generateWall()
        _hand = State(initialValue: Array(fullWall.prefix(13)))
        _wall = State(initialValue: Array(fullWall.dropFirst(13)))
    }
    
    var body: some View {
        VStack {
            Spacer()
            DiscardPileView(tiles: discards)
            Spacer()
            Text("Your Hand (\(wall.count) tiles left in wall)")
                .font(.headline)
            HandView(tiles: hand, onTileTapped: {index in
                let tile = hand.remove(at: index)
                discards.append(tile)
                if !wall.isEmpty {
                    hand.append(wall.removeFirst())
                }
            })
            .padding(.bottom)
        }
    }
}

#Preview {
    ContentView()
}
