//
//  ProjectileHandler.swift
//  StepQuest
//
//  Created by Max Hakin on 12/12/2023.
//

import Foundation
import SpriteKit

class ProjectileHandler {

    var projectiles: [Projectile] = []
    weak var gameScene: GameScene?

    init(gameScene: GameScene) {
        self.gameScene = gameScene
        towerPlaces = gameScene.getTowerPlaces()
    }

    func addProjectile(projectileType: String, startLocation: CGPoint, target: Enemy) {
        let projectile = Projectile(projectileType: projectileType, target: target)
        projectiles.append(projectile)
        projectile.position = startLocation
        gameScene?.addChild(projectile)
        print("Projectile Made")
    }
    
    func isTower(at place: SKShapeNode) -> Bool {
        if place.children.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    func update(enemies: [Enemy], deltaTime: TimeInterval) {
        for tower in towers {
            tower.update(enemies: enemies, deltaTime: deltaTime)
        }
    }

}
