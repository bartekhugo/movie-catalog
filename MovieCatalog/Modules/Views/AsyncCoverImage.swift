//
//  AsyncCoverImage.swift
//  InterviewOne
//
//  Created by Bartek Hugo on 26/5/26.
//

import SwiftUI

struct AsyncCoverImage: View {
    let url: URL?
    
    var body: some View {
        ZStack {
            AsyncImage(url: url) { phase in
                switch phase {
                    
                case .empty:
                    ShimmerView()
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                                        
                case .failure:
                    ZStack {
                        Color.gray.opacity(0.3)
                        
                        Image(systemName: "film")
                            .font(.largeTitle)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}


#Preview {
    AsyncCoverImage(url: Movie.stubbedMovie.posterURL)
}
