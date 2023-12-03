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
        let texture = SKTexture(imageNamed: baseImage)
        super.init()
        
        placeTower(location: location, towerName: towerType)
        
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
    
    func setTower(at location: CGPoint, towerName: String) {
        tileMap.setTileTower(at: location, towerName: towerName)
    }
    
    func getTower(at location: CGPoint) -> String {
        return tileMap.getTileTower(at: location)
    }
    
    
    func placeTower(location: CGPoint, towerName: String) {
        tileMap.setTileTower(at: location, towerName: towerName)
        let centre = tileMap.getTileCentre(at: location)
        
        base = SKSpriteNode(imageNamed: baseImage)
        turret = SKSpriteNode(imageNamed: turretImage)
        
        base?.zPosition = 2
        turret?.zPosition = 3
        
        base?.position = centre
        turret?.position = centre
        
        
    }
}

