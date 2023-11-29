//
//  Tower.swift
//  StepQuest
//
//  Created by Max Hakin on 28/11/2023.
//

import Foundation
import SpriteKit

class Tower: SKSpriteNode {
    var level: Int = 0
    var range: Float = 0
    var attackSpeed: Float = 0
    var imageFile: String = " "
    var damage: Int = 0
    var attackType: Int = 0
    var towerType: String = ""
    
    init(imageFile: String) {
        let texture = SKTexture(imageNamed: imageFile)
        super.init(texture: texture, color: .clear, size: texture.size())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //func attack(target: enemy) {
        
    //}
    
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
