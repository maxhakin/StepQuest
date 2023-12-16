//
//  TowerMenu.swift
//  StepQuest
//
//  Created by Louis Kürbis on 13/12/2023.
//

import Foundation
import SpriteKit

class TowerMenu: SKNode {
    
    var bombTowerButton: TowerMenuButton?
    var turretTowerButton: TowerMenuButton?
    var upgradeButton: TowerMenuButton?
    var deleteButton: TowerMenuButton?
    
    var baseImage: String?
    var topImage: String?
    
    init(menuType: String) {
        super.init()
        self.position = position
        switch menuType {
        case "initial":
            createInitialMenu()
        case "turret1":
            baseImage = "towerBase2"
            topImage = "turretGun2"
            createUpgradeMenu()
        case "turret2":
            baseImage = "towerBase3"
            topImage = "turretGun3"
            createUpgradeMenu()
        case "turret3":
            createDeleteMenu()
        case "missile1":
            baseImage = "towerBase2"
            topImage = "turretMissile2"
            createUpgradeMenu()
        case "missile2":
            baseImage = "towerBase3"
            topImage = "turretMissile3"
            createUpgradeMenu()
        case "missile3":
            createDeleteMenu()
        default:
            createInitialMenu()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func spaceButtons(button1: TowerMenuButton, button2: TowerMenuButton) {
        // Space between buttons
        let buttonSpacing: CGFloat = 10.0

        // Calculate total width of both buttons plus spacing
        let totalWidth = button1.size.width + button2.size.width + buttonSpacing

        // Position the buttons side by side
        button1.position = CGPoint(x: -totalWidth / 2 + bombTowerButton!.size.width / 2, y: 0)
        button2.position = CGPoint(x: totalWidth / 2 - turretTowerButton!.size.width / 2, y: 0)
    }
    
    // Create initial tower build menu with the chocie between the two types of towers
    private func createInitialMenu() {
        let turret = mergeImages(baseImage: "towerBase1", topImage: "turretGun1")
        let missile = mergeImages(baseImage: "towerBase1", topImage: "turretMissile1")
        
        bombTowerButton = TowerMenuButton(texture: missile, buttonText: "Missile Tower")
        turretTowerButton = TowerMenuButton(texture: turret, buttonText: "Turret Tower")
        
        spaceButtons(button1: bombTowerButton!, button2: turretTowerButton!)
        
        addChild(bombTowerButton!)
        addChild(turretTowerButton!)
    }
    
    func createUpgradeMenu() {
        let turret = mergeImages(baseImage: baseImage!, topImage: topImage!)
        
        upgradeButton = TowerMenuButton(texture: turret, buttonText: "Upgrade")
        
        addChild(upgradeButton!)
        
        createDeleteMenu()
        
        spaceButtons(button1: upgradeButton!, button2: deleteButton!)
        
    }
    
    func createDeleteMenu() {
        let delete = SKTexture(imageNamed: "delete")
        
        deleteButton = TowerMenuButton(texture: delete, buttonText: "Delete")
        
        addChild(deleteButton!)
    }

        // Add methods to handle button actions
    
    func mergeImages(baseImage: String, topImage: String) -> SKTexture {
        // Load the top and base images to merge
        let baseNode = SKSpriteNode(imageNamed: baseImage)
        let turretNode = SKSpriteNode(imageNamed: topImage)
        
        // Create a parent node
        let parentNode = SKNode()

        // Add base and turret to the parent node
        parentNode.addChild(baseNode)
        parentNode.addChild(turretNode)
        
        // Determine the size needed to fit both nodes
        let parentSize = CGSize(width: max(baseNode.size.width, turretNode.size.width), height: baseNode.size.height + turretNode.size.height)

        // Render the parent node to a texture
        let texture = SKView().texture(from: parentNode, crop: CGRect(origin: CGPoint(x: -parentSize.width / 2, y: -parentSize.height / 2), size: parentSize))!
        
        return texture
    }
    
}
