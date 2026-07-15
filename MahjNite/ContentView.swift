//
//  ContentView.swift
//  MahjNite
//
//  Created by Benjamin Guo on 7/12/26.
//

import SwiftUI

struct ContentView: View {
    let tiles: [Tile] = Array(generateWall().prefix(13))
    
    var body: some View {
        VStack {
            Spacer()
            Text("Your Hand")
                .font(.headline)
            HandView(tiles: tiles)
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
