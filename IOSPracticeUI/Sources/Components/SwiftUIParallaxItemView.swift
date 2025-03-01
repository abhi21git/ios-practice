//
//  SwiftUIParallaxItemView.swift
//  iOSPracticeUI
//
//  Created by Abhishek Maurya on 01/03/25.
//

import NukeUI
import SwiftUI

// MARK: - ParallaxItemView
public struct SwiftUIParallaxItemView: View {
    @State var imageURL: String
    @State var author: String
    
    public init(imageURL url: String, author name: String) {
        imageURL = url
        author = name
    }
    
    public var body: some View {
        ZStack {
            LazyImage(url: URL(string: imageURL)) { state in
                if let image = state.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                } else {
                    Image(systemName: "photo.artframe")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .ignoresSafeArea()
                        .padding(.all, 32)
                }
            }.processors(
                [.resize(width: 400)]
            )
            VStack(alignment: .leading) {
                Spacer()
                Text(author)
                    .font(.system(size: 24, design: .rounded))
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
                    .background(.ultraThinMaterial)
            }
        }
    }
}

// MARK: - Preview
#Preview(SwiftUIParallaxItemView.name, traits: SwiftUIParallaxItemView.traits, body: SwiftUIParallaxItemView.preview)
extension SwiftUIParallaxItemView: PreviewBuilderProtocol {
    public static var buildPreview: any View {
        SwiftUIParallaxItemView(
            imageURL: "https://picsum.photos/id/25/5000/3333",
            author: "Test"
        )
    }
}
