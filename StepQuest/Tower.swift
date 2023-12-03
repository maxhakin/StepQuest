//
//  Tower.swift
//  StepQuest
//
//  Created by Max Hakin on 28/11/2023.
//

import Foundation
import SpriteKit

class TurretTower: SKNode {
    var level: Int = 0
    var range: Float = 0
    var attackSpeed: Float = 0
    var base: SKSpriteNode
    var turret: SKSpriteNode
    var baseImage: String = ""
    var turretImage: String = ""
    var damage: Int = 0
    var attackType: Int = 0
    var towerType: String = "turret1"
    var tileMap: SKTileMapNode
    
    init(at location: CGPoint, map: SKTileMapNode) {
        self.tileMap = map
        let texture = SKTexture(imageNamed: baseImage)
        
        
        updateTowerMap(at: location, towerName: towerType)
        
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
    
    func updateTowerMap(at location: CGPoint, towerName: String) {
        // Convert the location to the tile tileMap's coordinate system
        let column = tileMap.tileColumnIndex(fromPosition: location)
        let row = tileMap.tileRowIndex(fromPosition: location)

        // Get the tile definition at this column and row
        if let tile = tileMap.tileDefinition(atColumn: column, row: row) {
            // Check if the tile has userData 'towerType'
            if let userData = tile.userData, userData["towerType"] as? String != nil {
                    // Update tower type on the tile map
                    userData["towerType"] = towerName
            }
        }
    }
    
    func makeTowerImg() {
        
    }
}

