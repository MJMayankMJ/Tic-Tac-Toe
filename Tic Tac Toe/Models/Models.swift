//
//  Models.swift
//  Tic Tac Toe
//
//  Created by Mayank Jangid on 4/22/25.
//

import SwiftUI

enum Player {
    case x, o
    var next: Player { self == .x ? .o : .x }
    var symbolColor: Color { self == .x ? .blue : .orange }
}

struct Move: Identifiable {
    let id = UUID()
    let player: Player
    let index: Int
}

