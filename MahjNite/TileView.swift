//
//  TileView.swift
//  MahjNite
//
//  Created by Benjamin Guo on 7/14/26.
//

import Foundation
import SwiftUI

struct TileView: View {
    let tile: Tile

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .frame(width: 48, height: 68)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(red: 0.91, green: 0.72, blue: 0.29), lineWidth: 1.5)
            )
            .overlay(
                VStack(spacing: 3) {
                    Text(tileSymbol)
                        .font(.system(size: 21, weight: .heavy, design: .rounded))
                        .foregroundColor(symbolColor)
                    Text(tileLabel)
                        .font(.system(size: 8, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 0.11, green: 0.16, blue: 0.29))
                        .textCase(.uppercase)
                }
            )
            .shadow(color: .black.opacity(0.12), radius: 3, x: 0, y: 2)
    }

    var symbolColor: Color {
        switch tile {
        case .suit(let suit, _):
            switch suit {
            case .characters: return Color(red: 0.11, green: 0.16, blue: 0.29)
            case .bamboos: return Color(red: 0.24, green: 0.60, blue: 0.44)
            case .circles: return Color(red: 1.0, green: 0.42, blue: 0.62)
            }
        case .honor(let honor):
            switch honor {
            case .dragon(.red): return Color(red: 1.0, green: 0.42, blue: 0.62)
            case .dragon(.green): return Color(red: 0.24, green: 0.60, blue: 0.44)
            case .dragon(.white): return Color(red: 0.11, green: 0.16, blue: 0.29)
            case .wind: return Color(red: 0.91, green: 0.72, blue: 0.29)
            }
        }
    }

    var tileSymbol: String {
        switch tile {
        case .suit(let suit, let rank):
            switch suit {
            case .characters: return "\(rank)萬"
            case .bamboos: return "\(rank)索"
            case .circles: return "\(rank)筒"
            }
        case .honor(let honor):
            switch honor {
            case .wind(let wind):
                switch wind {
                case .east: return "東"
                case .south: return "南"
                case .west: return "西"
                case .north: return "北"
                }
            case .dragon(let dragon):
                switch dragon {
                case .red: return "中"
                case .green: return "發"
                case .white: return "白"
                }
            }
        }
    }

    var tileLabel: String {
        switch tile {
        case .suit(let suit, let rank):
            switch suit {
            case .characters: return "\(rank) Char"
            case .bamboos: return "\(rank) Bam"
            case .circles: return "\(rank) Cir"
            }
        case .honor(let honor):
            switch honor {
            case .wind(let wind):
                switch wind {
                case .east: return "East"
                case .south: return "South"
                case .west: return "West"
                case .north: return "North"
                }
            case .dragon(let dragon):
                switch dragon {
                case .red: return "Red"
                case .green: return "Green"
                case .white: return "White"
                }
            }
        }
    }
}
