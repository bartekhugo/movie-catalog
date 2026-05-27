//
//  ShimmerVirew.swift
//  InterviewOne
//
//  Created by Bartek Hugo on 25/5/26.
//

import SwiftUI

struct ShimmerView: View {
    @State private var phase: CGFloat = -1

    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.gray.opacity(0.2),
                Color.gray.opacity(0.4),
                Color.gray.opacity(0.2)
            ]),
            startPoint: .leading,
            endPoint: .trailing
        )
        .mask(
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, .white.opacity(0.8), .clear]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .offset(x: phase * 100)
        )
        .onAppear {
            withAnimation(.linear(duration: 1).repeatForever(autoreverses: true)) {
                phase = 1
            }
        }
    }
}

#Preview {
    ShimmerView()
}
