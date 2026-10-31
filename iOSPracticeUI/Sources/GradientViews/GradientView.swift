//
//  GradientView.swift
//  IOSPracticeUI
//
//  Created by Simran Rout on 14/05/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import UIKit

public final class GradientView: UIImageView {
    
    var gradientColors: [CGColor] = [UIColor.randomColor.cgColor,
                                     UIColor.randomColor.cgColor]
    var locations: [CGFloat]? = [0.0, 1.0]
    
    public override func layoutSubviews() {
        self.contentMode = .scaleToFill
        self.image = drawGradientColor(in: self.bounds, colors: gradientColors)
    }
    
    func drawGradientColor(in rect: CGRect, colors: [CGColor]) -> UIImage? {
        let currentContext = UIGraphicsGetCurrentContext()
        currentContext?.saveGState()
        defer { currentContext?.restoreGState() }
        
        let size = rect.size
        guard size.width != 0 && size.height != 0 else { return nil }
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                        colors: colors as CFArray,
                                        locations: locations) else { return nil }
        
        let context = UIGraphicsGetCurrentContext()
        context?.drawLinearGradient(gradient,
                                    start: CGPoint.zero,
                                    end: CGPoint(x: size.width, y: size.height),
                                    options: [])
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return gradientImage
    }
}

//MARK: - Preview
#Preview(GradientView.name, traits: GradientView.traits, body: GradientView.preview)
extension GradientView: PreviewBuilderProtocol {
    public static var traits: PreviewTrait<Preview.ViewTraits> { .fixedLayout(width: 300, height: 300) }
    public static var buildPreview: UIView { GradientView() }
}
