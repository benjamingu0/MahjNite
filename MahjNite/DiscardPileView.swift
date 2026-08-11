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
            Text("DISCARDS")
                .font(.system(size: 13, weight: .heavy, design: .rounded))
                .foregroundColor(Color(red: 0.11, green: 0.16, blue: 0.29))
                .tracking(1)
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
