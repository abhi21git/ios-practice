//
//  PreviewBuilderProtocol.swift
//  IOSPractice
//
//  Created by Abhishek Maurya on 07/10/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import UIKit

@MainActor
public protocol PreviewBuilderProtocol {
    associatedtype someView
    static var name: String { get }
    static var traits: PreviewTrait<Preview.ViewTraits> { get }
    static var preview: @MainActor () -> someView { get }
    static var buildPreview: someView { get }
}

public extension PreviewBuilderProtocol {
    static var name: String {
        String(describing: self).replacingOccurrences(of: "([a-z])([A-Z][a-z])", with: "$1 $2", options: .regularExpression)
    }
    
    static var traits: PreviewTrait<Preview.ViewTraits> {
        return .defaultLayout
    }
    
    static var preview: @MainActor () -> someView {
        return { buildPreview }
    }
}
