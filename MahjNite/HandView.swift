//
//  HandView.swift
//  MahjNite
//
//  Created by Benjamin Guo on 7/15/26.
//

import Foundation
import SwiftUI

struct HandView: View {
    let tiles: [Tile]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(Array(tiles.enumerated()), id: \.offset) { index, tile in
                    TileView(tile: tile)
                }
            }
            
            .padding()
        }
    }
}
