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
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .shadow(radius: 3)
            
            VStack(spacing: 4) {
                Text(tileSymbol)
                    .font(.title2)
                Text(tileLabel)
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            
            .foregroundColor(.black)
        }
        
        .frame(width: 50, height: 70)
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
