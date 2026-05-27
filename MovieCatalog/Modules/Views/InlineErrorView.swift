//
//  InlineErrorView.swift
//  InterviewOne
//
//  Created by Bartek Hugo on 26/5/26.
//

import SwiftUI

struct InlineErrorView: View {

    let message: String
    let onRetry: () -> Void

    var body: some View {
        HStack {
            Text("Failed to load: \(message)")
                .foregroundStyle(.red)

            Spacer()

            Button("Retry") {
                onRetry()
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    InlineErrorView(message: "Error Message", onRetry: {})
}
