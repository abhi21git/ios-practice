//
//  View+Extensions.swift
//  PracticeProject
//
//  Created by Abhishek Maurya on 01/03/25.
//

import SwiftUI

public extension View {
    func onPressingChanged(_ action: @escaping (CGPoint?) -> Void) -> some View {
        modifier(SpatialPressingGestureModifier(action: action))
    }
}

// MARK: - SpatialPressingGestureModifier
struct SpatialPressingGestureModifier: ViewModifier {
    
    @State var currentLocation: CGPoint?
    var onPressingChanged: (CGPoint?) -> Void

    init(action: @escaping (CGPoint?) -> Void) {
        self.onPressingChanged = action
    }
    
    func body(content: Content) -> some View {
        let gesture = SpatialPressingGesture(location: $currentLocation)
        
        content
            .gesture(gesture)
            .onChange(of: currentLocation, initial: false) { _, location in
                onPressingChanged(location)
            }
    }
}

// MARK: - SpatialPressingGesture
struct SpatialPressingGesture: UIGestureRecognizerRepresentable {
    @Binding var location: CGPoint?
    
    func makeCoordinator(converter: CoordinateSpaceConverter) -> Coordinator {
        Coordinator()
    }
    
    func makeUIGestureRecognizer(context: Context) -> UILongPressGestureRecognizer {
        let recognizer = UILongPressGestureRecognizer()
        recognizer.minimumPressDuration = 0
        recognizer.delegate = context.coordinator
        return recognizer
    }
    
    func handleUIGestureRecognizerAction(_ recognizer: UIGestureRecognizerType, context: Context) {
        switch recognizer.state {
        case .began:
            location = context.converter.localLocation
        case .ended, .cancelled, .failed:
            location = nil
        default:
            break
        }
    }
    
    final class Coordinator: NSObject, UIGestureRecognizerDelegate {
        @objc func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith other: UIGestureRecognizer) -> Bool {
            true
        }
    }
}
