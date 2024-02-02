//
//  EnemyHandler.swift
//  StepQuest
//
//  Created by Max Hakin on 09/12/2023.
//

import Foundation
import SpriteKit

class EnemyHandler {
    
    var enemies: [Enemy] = []
    var flyPath: [SKNode] = []
    var walkPath: [SKNode] = []
    var gameScene: GameScene
    
    init (gameScene: GameScene) {
        flyPath = gameScene.flyPath
        walkPath = gameScene.walkPath
        self.gameScene = gameScene
    }
    
    func makeCrab() {
        let enemy = Enemy(path: walkPath, imageFile: "monsterCrab", health: 110, moveSpeed: 60.0, gameScene: gameScene)
        enemies.append(enemy)
        gameScene.addChild(enemy)
    }
    
    func makeNerd() {
        let enemy = Enemy(path: walkPath, imageFile: "monsterNerd", health: 60, moveSpeed: 80.0, gameScene: gameScene)
        enemies.append(enemy)
        gameScene.addChild(enemy)
    }
    
    func makeStomper() {
        let enemy = Enemy(path: walkPath, imageFile: "monsterStomp", health: 130, moveSpeed: 30.0, gameScene: gameScene)
        enemies.append(enemy)
        gameScene.addChild(enemy)
    }
    
    func makeAlien() {
        let enemy = Enemy(path: walkPath, imageFile: "monsterAlien", health: 100, moveSpeed: 50.0, gameScene: gameScene)
        enemies.append(enemy)
        gameScene.addChild(enemy)
    }
    
    func makeWings() {
        let enemy = Enemy(path: flyPath, imageFile: "monsterWings", health: 70, moveSpeed: 70.0, gameScene: gameScene)
        enemies.append(enemy)
        gameScene.addChild(enemy)
    }
    
    // Remove the enemys from the scene for when an enemy makes it to the end
    func removeAllEnemies() {
        for enemy in enemies {
            enemy.removeFromParent()
        }
    }
    
    func updateEnemies(deltaTime: TimeInterval) {
        // Reverse the array so removing any members wont create issues
        for (index, enemy) in enemies.enumerated().reversed() {
            if enemy.parent == nil {
                // Enemy has been removed from the scene, so remove it from the array
                enemies.remove(at: index)
                print("Enemy removed from array")
                if enemies.isEmpty {
                    gameScene.nextLevel()
                }
            } else {
                enemy.move(deltaTime: deltaTime)
            }
        }
    }
}
