//
//  GameViewModel.swift
//  Tic Tac Toe
//
//  Created by Mayank Jangid on 4/22/25.
//

import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var currentPlayer: Player = .x
    @Published var scores: [Player: Int] = [.x: 0, .o: 0]
    @Published var isGameOver = false
    @Published var winningLine: [Int] = []

    private var history: [[Move?]] = []
    private var future: [[Move?]] = []
    private let isAI: Bool

    // MARK: – Init
    init(isAI: Bool = false) {
        self.isAI = isAI
        restart()
    }

    // MARK: – Player Move
    func makeMove(at index: Int) {
        guard moves[index] == nil, !isGameOver else { return }
        history.append(moves)
        future.removeAll()

        moves[index] = Move(player: currentPlayer, index: index)
        triggerHaptic(style: .light)

        if let line = checkWin(for: currentPlayer) {
            // Win
            winningLine = line
            scores[currentPlayer, default: 0] += 1
            endGame()
        }
        else if moves.compactMap({ $0 }).count == 9 {
            // Draw
            endGame(isDraw: true)
        }
        else {
            // Next turn
            currentPlayer = currentPlayer.next
            maybePerformAIMove()
        }
    }

    // MARK: – AI Logic

    func maybePerformAIMove() {
        print("🔍 maybePerformAIMove fired — isAI=\(isAI), currentPlayer=\(currentPlayer), isGameOver=\(isGameOver)")
        guard isAI, currentPlayer == .o, !isGameOver else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.performSmartAIMove()
        }
    }


    private func performSmartAIMove() {
        let available = moves.indices.filter { moves[$0] == nil }

        // win if possible
        if let winIdx = findBestMove(for: .o, in: available) {
            makeMove(at: winIdx)
            return
        }
        // blockkkkk
        if let blockIdx = findBestMove(for: .x, in: available) {
            makeMove(at: blockIdx)
            return
        }
        // center
        if available.contains(4) {
            makeMove(at: 4)
            return
        }
        // random corner
        let corners = [0,2,6,8].filter(available.contains)
        if let c = corners.randomElement() {
            makeMove(at: c)
            return
        }
        // else make some random shit
        if let random = available.randomElement() {
            makeMove(at: random)
        }
    }

    private func findBestMove(for player: Player, in spots: [Int]) -> Int? {
        for idx in spots {
            var testBoard = moves
            testBoard[idx] = Move(player: player, index: idx)
            if checkWin(for: player, in: testBoard) != nil {
                return idx
            }
        }
        return nil
    }

    // MARK: – Win Detection

    private func checkWin(for player: Player) -> [Int]? {
        return checkWin(for: player, in: moves)
    }

    private func checkWin(for player: Player, in board: [Move?]) -> [Int]? {
        let combos = [
            [0,1,2], [3,4,5], [6,7,8],
            [0,3,6], [1,4,7], [2,5,8],
            [0,4,8], [2,4,6]
        ]
        let positions = board.compactMap { $0 }
                             .filter { $0.player == player }
                             .map { $0.index }
        for combo in combos where combo.allSatisfy(positions.contains) {
            return combo
        }
        return nil
    }

    // MARK: – Undo/Redo
    func undo() {
        guard let last = history.popLast() else { return }
        future.append(moves)
        moves = last
        currentPlayer = currentPlayer.next
        triggerHaptic(style: .medium)
    }

    func redo() {
        guard let nextState = future.popLast() else { return }
        history.append(moves)
        moves = nextState
        currentPlayer = currentPlayer.next
        triggerHaptic(style: .medium)
    }

    // MARK: – Restart & End
    func restart() {
        moves = Array(repeating: nil, count: 9)
        winningLine = []
        isGameOver = false
        history.removeAll()
        future.removeAll()

        // 50 - 50
        if isAI {
            currentPlayer = Bool.random() ? .x : .o
        } else {
            currentPlayer = .x
        }
        maybePerformAIMove()
    }

    private func endGame(isDraw: Bool = false) {
        isGameOver = true
        triggerHaptic(style: .heavy)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.restart()
        }
    }

    // MARK: – Haptics
    private func triggerHaptic(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}
