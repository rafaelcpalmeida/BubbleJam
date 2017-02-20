//
//  GameScene.swift
//  BubbleJam
//
//  Created by Rafael Almeida on 01/02/17.
//  Copyright © 2017 Rafael Almeida. All rights reserved.
//

import SpriteKit
import GameplayKit
import Foundation

class GameScene: SKScene {
    let gameLayer = SKNode()
    let bubblesLayer = SKNode()
    var bubbles: [Bubble] = []
    let pontuationLabel = SKLabelNode(fontNamed: "Arial")
    let gameOverLabel = SKLabelNode(fontNamed: "Arial")
    var pontuation = 0
    var gameOver = false
    var gameStarted = false
    let numberOfBubbles = 1
    let numberOfMissedBubbles = 3
    var missedBubbles = 0
    
    override init(size: CGSize) {
        super.init(size: size)
        
        backgroundColor = .white
        
        addChild(gameLayer)
        
        placeLabelTopLeft()
        
        gameLayer.addChild(pontuationLabel)
        
        bubblesLayer.position = CGPoint(x: 0, y: 0)
        gameLayer.addChild(bubblesLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        if missedBubbles == numberOfMissedBubbles {
            gameOverFnc()
        }
        
        while(bubblesLayer.children.count < numberOfBubbles) {
            self.addBall()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node: SKNode = self.atPoint(location)
            
            if node.name == "bubble" {
                if gameOver {
                    restartGame()
                }
                
                if !gameStarted {
                    gameStarted = true
                }
                
                pontuation += bubbles[0].points
                pontuationLabel.text = "Pontuation: \(pontuation)"
                
                node.run(SKAction.fadeAlpha(to: 0, duration: 0.08), completion: {
                    node.removeFromParent()
                })
                
                bubbles.remove(at: 0)
            } else if !gameOver && gameStarted {
                gameOverFnc()
            } else if gameOver {
                restartGame()
            }
        }
    }
    
    private func gameOverFnc() {
        gameOver = true
        gameStarted = false
    
        for case let bubble as SKShapeNode in bubblesLayer.children {
            bubble.removeAllActions()
        }
    
        placeLabelGameOver()
    }
    
    private func restartGame() {
        gameOverLabel.removeFromParent()
        
        for case let bubble as SKShapeNode in bubblesLayer.children {
            bubble.removeFromParent()
        }
        
        pontuation = 0
        placeLabelTopLeft()
        
        gameOver = false
        //gameStarted = true
        missedBubbles = 0
        
        addBall()
    }
    
    func addBall() {
        let bub = Bubble(width: size.width, height: size.height, currentPontuation: pontuation)
        
        bub.bubble.name = "bubble"
        
        bubblesLayer.addChild(bub.bubble)
        
        bubbles.append(bub)
        
        bub.bubble.run(SKAction.fadeAlpha(to: 0.5, duration: 0.10))
        
        if gameStarted && !gameOver {
            bub.bubble.run(SKAction.sequence([
                SKAction.wait(forDuration: bub.duration),
                ]), completion: {
                    bub.bubble.run(SKAction.fadeAlpha(to: 0, duration: 0.10))
                    bub.bubble.removeFromParent()
                    self.missedBubbles += 1
            })
        }
    }
    
    func placeLabelTopLeft() {
        pontuationLabel.text = "Pontuation: \(self.pontuation)"
        pontuationLabel.fontSize = 20
        pontuationLabel.fontColor = .black
        pontuationLabel.horizontalAlignmentMode = .left
        pontuationLabel.position = CGPoint(x: 5.0, y: (self.size.height-(CGFloat(pontuationLabel.fontSize)+1)))
    }
    
    func placeLabelGameOver() {
        gameOverLabel.removeFromParent()
        
        gameOverLabel.text = "Game Over!"
        gameOverLabel.fontSize = 40
        gameOverLabel.fontColor = .black
        gameOverLabel.horizontalAlignmentMode = .center
        gameOverLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        pontuationLabel.horizontalAlignmentMode = .center
        pontuationLabel.position = CGPoint(x: self.frame.midX, y: (self.frame.midY-(CGFloat(pontuationLabel.fontSize)+5)))
        
        gameLayer.addChild(gameOverLabel)
    }
}
