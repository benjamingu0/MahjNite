//
//  ExposedSetsView.swift
//  MahjNite
//
//  Created by Benjamin Guo on 8/6/26.
//

import Foundation
import SwiftUI

struct ExposedSetsView: View {
    let sets: [[Tile]]

    var body: some View {
        HStack(spacing: 12) {
            ForEach(0..<sets.count, id: \.self) { setIndex in
                HStack(spacing: 2) {
                    ForEach(0..<sets[setIndex].count, id: \.self) { tileIndex in
                        TileView(tile: sets[setIndex][tileIndex])
                    }
                }
                .padding(4)
                .background(Color.gray.opacity(0.15))
                .cornerRadius(8)
            }
        }
    }
}
