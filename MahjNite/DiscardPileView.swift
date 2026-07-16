//
//  DiscardPileView.swift
//  MahjNite
//
//  Created by Benjamin Guo on 7/16/26.
//

import Foundation
import SwiftUI

struct DiscardPileView: View {
    let tiles: [Tile]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Discards")
                .font(.headline)
                .padding(.horizontal)
            
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(54)), count: 6), spacing: 8) {
                ForEach(Array(tiles.enumerated()), id: \.offset) { index, tile in
                    TileView(tile: tile)
                }
            }
        }
        
        .padding(.horizontal)
    }
}
