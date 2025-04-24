//
//  ConfettiView.swift
//  Tic Tac Toe
//
//  Created by Mayank Jangid on 4/22/25.
//

import SwiftUI

import SwiftUI
import UIKit

struct ConfettiView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let emitter = CAEmitterLayer()
        emitter.emitterShape = .line
        emitter.emitterPosition = CGPoint(x: UIScreen.main.bounds.midX, y: -10)
        emitter.emitterSize = CGSize(width: UIScreen.main.bounds.width, height: 2)
        emitter.emitterCells = (0..<8).map { _ in
            let cell = CAEmitterCell()
            cell.birthRate = 4
            cell.lifetime = 7.0
            cell.velocity = 150
            cell.velocityRange = 100
            cell.emissionLongitude = .pi
            cell.spin = 4
            cell.spinRange = 2
            cell.scale = 0.1
            cell.scaleRange = 0.2
            cell.contents = UIImage(systemName: "circle.fill")?.cgImage
            cell.color = UIColor(
                red: .random(in: 0...1),
                green: .random(in: 0...1),
                blue: .random(in: 0...1),
                alpha: 1
            ).cgColor
            return cell
        }
        view.layer.addSublayer(emitter)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            emitter.birthRate = 0
        }
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {}
}


#Preview {
    ConfettiView()
}
