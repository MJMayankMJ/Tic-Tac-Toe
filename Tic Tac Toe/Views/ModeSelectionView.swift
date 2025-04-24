//
//  ModeSelectionView.swift
//  Tic Tac Toe
//
//  Created by Mayank Jangid on 4/22/25.
//

import SwiftUI

struct ModeSelectionView: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 32) {
                Spacer()
                Text("Choose your play mode")
                    .font(.headline)

                Button("With AI") {
                    path.append(Mode.ai)
                }
                .buttonStyle(FilledButton())

                Button("With Friend") {
                    path.append(Mode.human)
                }
                .buttonStyle(BorderButton())

                Spacer()
//                Image(systemName: "gearshape.fill")
//                    .font(.title)
//                    .foregroundColor(.gray) -- for future when i add sound
            }
            .padding()
            .navigationTitle("Tic Tac Toe")
            .navigationDestination(for: Mode.self) { mode in
                GameView(isAI: mode == .ai)
            }
        }
    }

    enum Mode { case ai, human }
}


struct ModeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ModeSelectionView()
    }
}
