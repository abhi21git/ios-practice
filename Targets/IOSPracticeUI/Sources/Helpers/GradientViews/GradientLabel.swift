//
//  GradientLabel.swift
//  Collectionview
//
//  Created by Abhishek Maurya on 11/05/23.
//

import UIKit

public final class GradientTextLabel: UILabel {
    var gradientColors: [CGColor] = [UIColor(r: 234, g: 141, b: 141).cgColor,
                                     UIColor(r: 168, g: 154, b: 254).cgColor]
    var locations: [CGFloat]? = [0.0, 1.0]
    
    public override func drawText(in rect: CGRect) {
        if let gradientColor = drawGradientColor(in: rect, colors: gradientColors) {
            self.textColor = gradientColor
        }
        super.drawText(in: rect)
    }
    
    private func drawGradientColor(in rect: CGRect, colors: [CGColor]) -> UIColor? {
        let currentContext = UIGraphicsGetCurrentContext()
        currentContext?.saveGState()
        defer { currentContext?.restoreGState() }
        
        let size = rect.size
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                        colors: colors as CFArray,
                                        locations: locations) else { return nil }
        
        let context = UIGraphicsGetCurrentContext()
        context?.drawLinearGradient(gradient,
                                    start: CGPoint(x: 0, y: 0),
                                    end: CGPoint(x: size.width, y: size.height),
                                    options: [])
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let image = gradientImage else { return nil }
        return UIColor(patternImage: image)
    }
}
