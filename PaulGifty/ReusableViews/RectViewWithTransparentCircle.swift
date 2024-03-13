//
//  RectViewWithTransparentCircle.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 13/03/24.
//

import UIKit


class RectViewWithTransparentCircle: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Get the current graphics context
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // Set the blend mode to clear to punch a hole through the view
        context.setBlendMode(.clear)
        
        // Calculate the radius of the circular hole
        let holeRadius = min(bounds.width, bounds.height) / 2.5
        
        // Calculate the center of the view
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        // Create a circular path
        let circularPath = UIBezierPath(arcCenter: center, radius: holeRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        
        // Add the circular path to the context
        circularPath.fill()
    }
}
