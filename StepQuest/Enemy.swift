//
//  Enemy.swift
//  StepQuest
//
//  Created by Louis Kürbis on 29/11/2023.
//

import Foundation
import SpriteKit

class Enemy: SKSpriteNode {
    var imageFile: String = " "
    var health: Int?
    var walkSpeed: Float?
    var scale: Int?
    
    
    init(imageFile: String) {
        let texture = SKTexture(imageNamed: imageFile)
        super.init(texture: texture, color: .clear, size: texture.size())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func takeDamage() {
        
    }
    
    func die() {
        
    }
    
    func followPath() {
        
    }
}
