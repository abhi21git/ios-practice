//
//  RippleEffect.swift
//  PracticeProject
//
//  Created by Abhishek Maurya on 01/03/25.
//

import Metal
import SwiftUI

fileprivate class BundleFinder {}

/// A modifer that performs a ripple effect to its content whenever its
/// trigger value changes.
public struct RippleEffect<T: Equatable>: ViewModifier {
    var origin: CGPoint
    
    var trigger: T
    
    public init(at origin: CGPoint, trigger: T) {
        self.origin = origin
        self.trigger = trigger
    }
    
    public func body(content: Content) -> some View {
        let origin = origin
        let duration = duration
        
        content.keyframeAnimator(
            initialValue: 0,
            trigger: trigger
        ) { view, elapsedTime in
            view.modifier(RippleModifier(
                origin: origin,
                elapsedTime: elapsedTime,
                duration: duration
            ))
        } keyframes: { _ in
            MoveKeyframe(0)
            LinearKeyframe(duration, duration: duration)
        }
    }
    
    var duration: TimeInterval { 3 }
}

/// A modifier that applies a ripple effect to its content.
struct RippleModifier: ViewModifier {
    var origin: CGPoint
    
    var elapsedTime: TimeInterval
    
    var duration: TimeInterval
    
    var amplitude: Double = 12
    var frequency: Double = 15
    var decay: Double = 8
    var speed: Double = 1200
    
    func body(content: Content) -> some View {
        let shader = ShaderLibrary.bundle(Bundle(for: BundleFinder.self)).Ripple(
            .float2(origin),
            .float(elapsedTime),
            
            // Parameters
            .float(amplitude),
            .float(frequency),
            .float(decay),
            .float(speed)
        )
        let maxSampleOffset = maxSampleOffset
        let elapsedTime = elapsedTime
        let duration = duration
        
        content.visualEffect { view, _ in
            view.layerEffect(
                shader,
                maxSampleOffset: maxSampleOffset,
                isEnabled: 0 < elapsedTime && elapsedTime < duration
            )
        }
    }
    
    var maxSampleOffset: CGSize {
        CGSize(width: amplitude, height: amplitude)
    }
}
