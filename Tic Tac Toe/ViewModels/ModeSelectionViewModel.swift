//
//  ModeSelectionViewModel.swift
//  Tic Tac Toe
//
//  Created by Mayank Jangid on 4/22/25.
//

import SwiftUI

class ModeSelectionViewModel: ObservableObject {
    enum Mode { case ai, human }
    @Published var selectedMode: Mode? = nil
}
