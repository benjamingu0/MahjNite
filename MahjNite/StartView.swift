//
//  StartView.swift
//  MahjNite
//
//  Created by Benjamin Guo on 8/12/26.
//

import Foundation
import SwiftUI

struct StartView: View {
    @State private var showGame = false

    var body: some View {
        if showGame {
            ContentView()
        } else {
            ZStack {
                Color(red: 0.99, green: 0.97, blue: 0.94)
                    .ignoresSafeArea()

                VStack(spacing: 24) {
                    Spacer()

                    Text("MAHJ NITE")
                        .font(.system(size: 42, weight: .heavy, design: .rounded))
                        .foregroundColor(Color(red: 0.11, green: 0.16, blue: 0.29))
                        .tracking(2)

                    Text("Hong Kong Style Mahjong")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 0.24, green: 0.60, blue: 0.44))
                        .tracking(1)

                    Spacer()

                    Button {
                        showGame = true
                    } label: {
                        Text("NEW GAME")
                            .font(.system(size: 16, weight: .heavy, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 16)
                            .background(
                                Capsule()
                                    .fill(Color(red: 1.0, green: 0.42, blue: 0.62))
                            )
                    }

                    Spacer()
                }
            }
        }
    }
}

#Preview {
    StartView()
}
