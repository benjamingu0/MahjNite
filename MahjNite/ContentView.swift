//
//  ContentView.swift
//  MahjNite
//
//  Created by Benjamin Guo on 7/12/26.
//

import SwiftUI

struct ContentView: View {
    @State private var hand: [Tile] = generateWall().prefix(12).map { $0 }
    @State private var discards: [Tile] = []
    
    var body: some View {
        VStack {
            Spacer()
            DiscardPileView(tiles: discards)
            Spacer()
            Text("Your Hand")
                .font(.headline)
            HandView(tiles: hand, onTileTapped: { index in
                let tile = hand.remove(at: index)
                discards.append(tile)
            })
            .padding(.bottom)
        }
    }
}

#Preview {
    ContentView()
}
