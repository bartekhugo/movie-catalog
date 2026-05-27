//
//  PosterCard.swift
//  InterviewOne
//
//  Created by Bartek Hugo on 25/5/26.
//

import SwiftUI

struct PosterCard: View {
    let movie: Movie
    let aspectRatio: CGFloat
    
    init(movie: Movie, aspectRatio: CGFloat = 2/3) {
        self.movie = movie
        self.aspectRatio = aspectRatio
    }
    
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(spacing: 8) {
            AsyncCoverImage(url: movie.posterURL)
                .aspectRatio(aspectRatio, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .hoverEffect(.lift)

            Text(movie.title)
                .font(.caption)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineLimit(2, reservesSpace: true)
                .offset(y: isFocused ? 24 : 0)
                .opacity(isFocused ? 1 : 0)
        }
        .animation(.easeInOut(duration: 0.2), value: isFocused)
        .focusable()
        .focused($isFocused)
    }
}

#Preview {
    PosterCard(movie: Movie.stubbedMovie)
}
