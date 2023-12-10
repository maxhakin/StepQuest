//
//  Tower.swift
//  StepQuest
//
//  Created by Max Hakin on 28/11/2023.
//

import Foundation
import SpriteKit

class TurretTower: Tower {
    enum TowerLevel {
        case level1
        case level2
        case level3

        var stats: (range: CGFloat, attackSpeed: Float, damage: Int, baseImage: String, topImage: String) {
            switch self {
                case .level1:
                    return (800, 50, 10, "towerBase1", "turretGun1")
                case .level2:
                    return (1500, 75, 20, "towerBase2", "turretGun2")
                case .level3:
                    return (2000, 100, 30, "towerBase3", "turretGun3")
            }
        }
    }
    var level: TowerLevel
    
    
    
    init(placeNode: SKShapeNode, levelString: String) {
        switch levelString {
            case "level1":
                level = .level1
            case "level2":
                level = .level2
            case "level3":
                level = .level3
            default:
                level = .level1
        }
        
        let stats = level.stats
        super.init()
        
        range = stats.range
        attackSpeed = stats.attackSpeed
        damage = stats.damage
        baseImage = stats.baseImage
        topImage = stats.topImage
        
        makeTower()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    
}

