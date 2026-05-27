//
//  BackdropCard.swift
//  InterviewOne
//
//  Created by Bartek Hugo on 25/5/26.
//

import SwiftUI

struct BackdropCard: View {
    let movie: Movie
    let aspectRatio: CGFloat
    
    var titleHidden: Bool
    
    init(movie: Movie, titleHidden: Bool = false, aspectRatio: CGFloat = 16/9) {
        self.movie = movie
        self.titleHidden = titleHidden
        self.aspectRatio = aspectRatio
    }
    
    var body: some View {
        GeometryReader() { geo in
            ZStack(alignment: .bottomLeading) {

                AsyncCoverImage(url: movie.backdropURL)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                if (!titleHidden) {
                    Text(movie.title)
                        .font(.body)
                        .foregroundColor(.white)
                        .padding(16)
                }
            }
            .cornerRadius(12)
            .hoverEffect(.lift)
            .focusable()
        }
        .aspectRatio(aspectRatio, contentMode: .fit)
    }

}

#Preview {
    BackdropCard(movie: Movie.stubbedMovie)
}

