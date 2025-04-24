//
//  CellView.swift
//  Tic Tac Toe
//
//  Created by Mayank Jangid on 4/22/25.
//

import SwiftUI

struct CellView: View {
    let move: Move?
    let isWinning: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(isWinning ? Color.green : Color.gray, lineWidth: isWinning ? 4 : 2)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            if let move = move {
                if move.player == .x {
                    XShape()
                        .stroke(move.player.symbolColor, lineWidth: 8)
                        .animation(.easeIn, value: move.id)
                } else {
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(move.player.symbolColor, lineWidth: 8)
                        .animation(.easeIn, value: move.id)
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            CellView(move: Move(player: .x, index: 0), isWinning: false)
                .frame(width: 100, height: 100)

            CellView(move: Move(player: .o, index: 1), isWinning: false)
                .frame(width: 100, height: 100)

            CellView(move: Move(player: .x, index: 2), isWinning: true)
                .frame(width: 100, height: 100)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
