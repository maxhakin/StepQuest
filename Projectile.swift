//
//  Projectile.swift
//  StepQuest
//
//  Created by Louis Kürbis on 12/12/2023.
//

import Foundation
import SpriteKit

class Projectile: SKNode {
    
    var imageFile: String
    var damage: Int
    var damageRadius: CGFloat
    var movingSpeed: CGFloat
    var projImage: SKSpriteNode
    
    var target: Enemy
    
    
    enum ProjectileType {
        case bullet1
        case bullet2
        case bullet3
        case bomb1
        case bomb2
        case bomb3

        var stats: (imageFile: String, damage: Int, damageRadius: CGFloat, movingSpeed: CGFloat) {
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
        movingSpeed = stats.movingSpeed
        projImage = SKSpriteNode(imageNamed: imageFile)
        
        super.init()
        
        addChild(projImage)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeProjectile() {
        
    }
    
}
