//
//  XShape.swift
//  Tic Tac Toe
//
//  Created by Mayank Jangid on 4/22/25.
//

import SwiftUI

// just using this instead of asset cz want to practice this kinda thing
struct XShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        return path
    }
}
