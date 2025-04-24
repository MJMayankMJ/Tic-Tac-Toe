//
//  GameView.swift
//  Tic Tac Toe
//
//  Created by Mayank Jangid on 4/22/25.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel: GameViewModel
    let isAI: Bool

    init(isAI: Bool) {
        print("🧠 GameView init — isAI = \(isAI)") // this is for debugging cz of some issue....
        self.isAI = isAI
        _viewModel = StateObject(wrappedValue: GameViewModel(isAI: isAI))
    }


    private let columns = Array(repeating: GridItem(.flexible()), count: 3)

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("You")
                    Spacer()
                    Text("\(viewModel.scores[.x] ?? 0) - \(viewModel.scores[.o] ?? 0)")
                        .font(.headline)
                    Spacer()
                    Text(isAI ? "AI" : "Friend")
                }
                .padding()

                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(0..<9) { i in
                        CellView(move: viewModel.moves[i], isWinning: viewModel.winningLine.contains(i))
                            .onTapGesture {
                                viewModel.makeMove(at: i)
                            }
                    }
                }
                .padding()
                Spacer()
            }
            .navigationBarItems(trailing: Button(action: { viewModel.restart() }) {
                Image(systemName: "arrow.counterclockwise")
            })

            VStack {
                Spacer()
                HStack {
                    Button(action: viewModel.undo) {
                        Image(systemName: "arrow.uturn.left")
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                    }
                    Spacer()
                    Button(action: viewModel.redo) {
                        Image(systemName: "arrow.uturn.right")
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                    }
                }
                .padding()
            }

            if viewModel.isGameOver {
                ConfettiView()
            }
        }
        .navigationTitle("Tic Tac Toe")
        .onAppear {
                    if isAI && viewModel.currentPlayer == .o {
                        viewModel.maybePerformAIMove()
                    }
                }
    }
}
#Preview {
    GameView(isAI: true)
}
