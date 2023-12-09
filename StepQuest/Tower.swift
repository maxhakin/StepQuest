//
//  Tower.swift
//  StepQuest
//
//  Created by Louis Kürbis on 08/12/2023.
//

import Foundation
import SpriteKit

class Tower: SKNode {
    var range: Float = 0
    var attackSpeed: Float = 0
    var damage: Int = 0
    
    var baseImage: String = ""
    var topImage: String = ""
    var base: SKSpriteNode?
    var top: SKSpriteNode?
    
    var towerType: String = ""
    var placeNode: SKShapeNode?
    var towerLocation: CGPoint?
    var enemy: Enemy?
    
    var scale: CGFloat = 0.65
    
    init(placeNode: SKShapeNode) {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //func attack(target: enemy) {
        
    //}
    
    func makeTower(placeNode: SKShapeNode) {
        base = SKSpriteNode(imageNamed: baseImage)
        top = SKSpriteNode(imageNamed: topImage)
        self.placeNode = placeNode
        
        let centreX = placeNode.frame.midX
        let centreY = placeNode.frame.midY
        let centre = CGPoint(x: centreX, y: centreY)
        
        base = SKSpriteNode(imageNamed: baseImage)
        top = SKSpriteNode(imageNamed: topImage)
        
        base?.zPosition = 2
        top?.zPosition = 3
        
        base?.setScale(scale)
        top?.setScale(scale)
        
        // Add base and turret as children to the TurretTower
        if let base = base, let top = top {
            addChild(base)
            addChild(top)
        }
   
        print(centre)
       
    }
    
    
    func upgrade() {
        
    }
    
    func findTarget() {
        
    }
    
    func targetInRange() {
        
    }
    
    func rotateTurret() {
        
    }
    
    func erase() {
        
    }
    
    func update() {
        
    }
    
    func render() {
        
    }
    
    
    
}

