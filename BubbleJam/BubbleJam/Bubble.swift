//
//  Bubble.swift
//  BubbleJam
//
//  Created by Rafael Almeida on 04/02/17.
//  Copyright © 2017 Rafael Almeida. All rights reserved.
//

import Foundation
import SpriteKit

class Bubble {
    var size: Int
    var x: Int
    var y: Int
    var path: CGMutablePath = CGMutablePath()
    var bubble: SKShapeNode
    var color: UIColor = .black
    var duration: TimeInterval = 0
    
    init(width: CGFloat, height: CGFloat, currentPontuation: Int) {
        self.size = Int(arc4random_uniform(UInt32((Int(width*0.15) + Int(width*0.08)) - (Int(width*0.08))))) + (Int(width*0.08))
        
        self.x = Int(arc4random_uniform(UInt32((width - CGFloat(size)) - CGFloat(size))) + UInt32(size))
        
        self.y = Int(arc4random_uniform(UInt32((height - CGFloat(size)) - CGFloat(size))) + UInt32(size))
        
        self.path.addArc(center: CGPoint.zero,
                    radius: CGFloat(size),
                    startAngle: 0,
                    endAngle: CGFloat.pi * 2,
                    clockwise: true)
        
        self.bubble = SKShapeNode(path: path)
        self.color = self.getRandomColor()
        self.duration = self.getDuration(currentPontuation: currentPontuation)
        
        bubble.position = CGPoint(x: x, y: y)
        bubble.setScale(1.0)
        bubble.strokeColor = color
        bubble.fillColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getRandomColor() -> UIColor{
        let colors = [UIColor(red:0.08, green:0.52, blue:0.53, alpha:1.0), UIColor(red:0.38, green:0.51, blue:0.18, alpha:1.0), UIColor(red:0.28, green:0.28, blue:0.28, alpha:1.0), UIColor(red:0.90, green:0.90, blue:0.06, alpha:1.0), UIColor(red:0.86, green:0.53, blue:0.20, alpha:1.0)]
        //blue, green, gray, yellow, orange
        
        return colors[Int(arc4random_uniform(4) + 1)]
    }
    
    private func getDuration(currentPontuation: Int) -> Double {
        duration = 0
        
        switch (currentPontuation) {
        case 1..<5:
            duration = 1.5
            break
        case 5..<10:
            duration = 1.25
            break
        case 10..<15:
            duration = 1.05
            break
        case 15..<22:
            duration = 0.85
            break
        case 22..<28:
            duration = 0.75
            break
        case 28..<35:
            duration = 0.50
            break
        default:
            duration = 0.48
            break
        }
        
        return duration
    }
}
