//
//  Tower.swift
//  StepQuest
//
//  Created by Max Hakin on 28/11/2023.
//

import Foundation
import SpriteKit

class TurretTower: SKNode {
    var level: Int = 1
    var range: Float = 100
    var attackSpeed: Float = 50
    var base: SKSpriteNode?
    var turret: SKSpriteNode?
    var baseImage: String = "towerBase1"
    var turretImage: String = "turretGun1"
    var damage: Int = 0
    var attackType: Int = 0
    var towerType: String = "turret1"
    var tileMap: SKTileMapNode
    var towerLocation: CGPoint
    
    init(at location: CGPoint, map: SKTileMapNode) {
        self.tileMap = map
        self.towerLocation = location
        super.init()
        self.name = towerType
        let texture = SKTexture(imageNamed: baseImage)
        
        
        placeTower(location: location)
        
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
    
    func setTower(at location: CGPoint, tower: TurretTower) {
        tileMap.setTileTower(at: location, tower: tower)
    }
    
    func getTower(at location: CGPoint) -> String {
        return tileMap.getTileTower(at: location)
    }
    
    
    func placeTower(location: CGPoint) {
        let centre = tileMap.getTileCentre(at: location)
        
        base = SKSpriteNode(imageNamed: baseImage)
        turret = SKSpriteNode(imageNamed: turretImage)
        
        base?.zPosition = 2
        turret?.zPosition = 3
        
        base?.position = centre
        turret?.position = centre
        
        // Add base and turret as children to the TurretTower
        if let base = base, let turret = turret {
            addChild(base)
            addChild(turret)
        }
        
    }
}

