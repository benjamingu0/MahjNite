//
//  ContentView.swift
//  MahjNite
//
//  Created by Benjamin Guo on 7/12/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TileView(tile: .suit(suit: .bamboos, rank: 5))
    }
}

#Preview {
    ContentView()
}
