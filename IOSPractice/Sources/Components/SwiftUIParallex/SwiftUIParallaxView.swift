//
//  SwiftUIParallaxView.swift
//  iOSPractice
//
//  Created by Abhishek Maurya on 01/03/25.
//

import iOSPracticeKit
import iOSPracticeUI
import SwiftUI

// MARK: - SwiftUIParallaxView
struct SwiftUIParallaxView: View {
    @ObservedObject var viewModel: LPViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 16) {
                ForEach(viewModel.data) { data in
                    ParallaxView(imageURL: data.imageURL, author: data.author)
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(32)
        .background(Color.primary.colorInvert())
        .scrollTargetBehavior(.viewAligned)
        .onAppear {
            viewModel.loadData()
        }
    }
}

// MARK: - ParallaxView
struct ParallaxView: View {
    let imageURL: String
    let author: String

    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        ZStack {
            SwiftUIParallaxItemView(imageURL: imageURL, author: author)
                .scrollTransition(axis: .horizontal) { content, phase in
                    content.offset(x: phase.isIdentity ? 0 : phase.value * -200)
                }
        }
        .containerRelativeFrame(.horizontal, count: verticalSizeClass == .regular ? 1 : 2, spacing: 16)
        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
    }
}

// MARK: - Preview
#Preview(SwiftUIParallaxView.name, traits: SwiftUIParallaxView.traits, body: SwiftUIParallaxView.preview)
extension SwiftUIParallaxView: PreviewBuilderProtocol {
    public static var buildPreview: any View {
        SwiftUIParallaxView(viewModel: LPViewModel())
    }
}
