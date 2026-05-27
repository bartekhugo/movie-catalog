//
//  HorizontalCarouselView.swift
//  InterviewOne
//
//  Created by Bartek Hugo on 25/5/26.
//

import SwiftUI

struct HorizontalCarouselView<Item: Identifiable, Content: View, Placeholder: View>: View {
    
    let items: [Item]
    let content: (Item) -> Content
    var onReachEnd: (() async -> Void)?
    let isLoading: Bool
    let placeholder: () -> Placeholder
    
    init(
        items: [Item],
        isLoading: Bool = false,
        @ViewBuilder placeholder: @escaping () -> Placeholder,
        onReachEnd: (() async -> Void)? = nil,
        @ViewBuilder content: @escaping (Item) -> Content) {
            self.items = items
            self.content = content
            self.onReachEnd = onReachEnd
            self.isLoading = isLoading
            self.placeholder = placeholder
        }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top, spacing: 32) {
                ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                    content(item)
                        .onAppear {
                            if index == items.count - 3 {
                                Task { await onReachEnd?() }
                            }
                        }
                }
                
                    if isLoading {
                        self.placeholder()
                            .overlay {
                                ProgressView()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                    }
                    

            }
        }
        .scrollClipDisabled()
    }
}
