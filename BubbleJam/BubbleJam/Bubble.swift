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
    var points: Int = 0
    
    init(width: CGFloat, height: CGFloat, currentPontuation: Int) {
        self.size = Int(arc4random_uniform(UInt32((Int(width*0.09) + Int(width*0.06)) - (Int(width*0.06))))) + (Int(width*0.06))
        
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
        self.points = self.getPoint(size: size)
        
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
        case 0..<20:
            duration = 1.25
            break
        case 20..<30:
            duration = 1.10
            break
        case 30..<45:
            duration = 0.90
            break
        case 45..<60:
            duration = 0.75
            break
        case 60..<80:
            duration = 0.65
            break
        case 80..<100:
            duration = 0.48
            break
        default:
            duration = 0.45
            break
        }
        
        return duration
    }
    
    private func getPoint(size: Int) -> Int {
        var point = 0
        
        switch (size) {
        case 0..<30:
            point = 5
            break
        case 30..<45:
            point = 3
            break
        default:
            point = 1
            break
        }
        
        return point
    }
}
