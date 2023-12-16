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
        case turret1
        case turret2
        case turret3

        var stats: (range: CGFloat, attackSpeed: TimeInterval, damage: Int, baseImage: String, topImage: String, projectileType: String, towerType: String) {
            switch self {
                case .turret1:
                    return (400, 10, 10, "towerBase1", "turretGun1", "bullet1", "turret1")
                case .turret2:
                    return (500, 7, 20, "towerBase2", "turretGun2", "bullet1", "turret2")
                case .turret3:
                    return (600, 5, 30, "towerBase3", "turretGun3", "bullet2", "turret3")
            }
        }
    }
    var level: TowerLevel
    
    
    
    init(levelString: String, enemyHandler: EnemyHandler) {
        switch levelString {
            case "turret1":
                level = .turret1
            case "turret2":
                level = .turret2
            case "turret3":
                level = .turret3
            default:
                level = .turret1
        }
        
        let stats = level.stats
        super.init(enemyHandler: enemyHandler)
        
        range = stats.range
        attackSpeed = stats.attackSpeed
        damage = stats.damage
        baseImage = stats.baseImage
        topImage = stats.topImage
        projectileType = stats.projectileType
        towerType = stats.towerType
        
        makeTower()
        createRangeCircle()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    
}

