//
//  Projectile.swift
//  StepQuest
//
//  Created by Max Hakin on 12/12/2023.
//

import Foundation
import SpriteKit

class Projectile: SKNode {
    
    var imageFile: String
    var damage: Int
    var damageRadius: CGFloat
    var moveSpeed: CGFloat
    var projImage: SKSpriteNode
    
    var target: Enemy
    var lastPos: CGPoint = CGPoint(x: 0, y: 0)
    
    
    enum ProjectileType {
        case bullet1
        case bullet2
        case bullet3
        case bomb1
        case bomb2
        case bomb3

        var stats: (imageFile: String, damage: Int, damageRadius: CGFloat, moveSpeed: CGFloat) {
            switch self {
                case .bullet1:
                    return ("bullet1", 30, 20, 200)
                case .bullet2:
                    return ("bullet1", 45, 25, 210)
                case .bullet3:
                    return ("bullet2", 60, 30, 220)
                case .bomb1:
                    return ("bomb1", 50, 50, 150)
                case .bomb2:
                    return ("bomb1", 65, 60, 160)
                case .bomb3:
                    return ("bomb2", 80, 70, 170)
            }
        }
    }
    
    var projectile: ProjectileType
    
    init(projectileType: String, target: Enemy) {
        switch projectileType {
        case "bullet1":
            projectile = .bullet1
        case "bullet2":
            projectile = .bullet2
        case "bullet3":
            projectile = .bullet3
        case "bomb1":
            projectile = .bomb1
        case "bomb2":
            projectile = .bomb2
        case "bomb3":
            projectile = .bomb3
        default:
            projectile = .bullet1
        }
        
        let stats = projectile.stats
        
        imageFile = stats.imageFile
        damage = stats.damage
        damageRadius = stats.damageRadius
        moveSpeed = stats.moveSpeed
        projImage = SKSpriteNode(imageNamed: imageFile)
        
        self.target = target
        
        super.init()
        
        self.zPosition = 4
        addChild(projImage)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        
    }
    
    func damageEnemy() {
        target.takeDamage(damage: damage)
    }
    
    func move(deltaTime: TimeInterval) {
        // Calculate the distance between the current position and the target
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let distance = hypot(dx, dy)

        // Calculate the angle between current position and target position
        let angle = atan2(dy, dx)
        
        // Rotate projectile to face target
        projImage.zRotation = angle + .pi / 2

        // Calculate the x and y components of the velocity
        let velocityX = cos(angle) * moveSpeed
        let velocityY = sin(angle) * moveSpeed

        // Move the projectile
        let deltaX = velocityX * CGFloat(deltaTime)
        let deltaY = velocityY * CGFloat(deltaTime)
        position.x += deltaX
        position.y += deltaY

        // Check if the projectile has reached the target
        if distance <= moveSpeed * CGFloat(deltaTime) {
            damageEnemy()
            removeFromParent()
        }
        
        // Fixes a bug of frozen projectiles
        if lastPos == self.position {
            removeFromParent()
        }
        
        lastPos = self.position
    }
    
    deinit {
        print("Projectile has been removed")
    }
}
