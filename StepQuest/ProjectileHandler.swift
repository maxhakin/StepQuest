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
    }

    func makeProjectile(projectileType: String, startLocation: CGPoint, target: Enemy) {
        let projectile = Projectile(projectileType: projectileType, target: target)
        projectiles.append(projectile)
        projectile.position = startLocation
        gameScene?.addChild(projectile)
        print("Projectile Made")
    }
    
    func update(deltaTime: TimeInterval) {
        for projectile in projectiles {
            projectile.move(deltaTime: deltaTime)
        }
    }

}
