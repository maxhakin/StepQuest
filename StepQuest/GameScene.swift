//
//  GameScene.swift
//  StepQuest
//
//  Created by Max Hakin on 27/11/2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var inputHandler: InputHandler!
    private var initialTouchLocation: CGPoint?
    private var terrainMap: SKTileMapNode?
    private var gameCam: SKCameraNode?
    var walkPath: [SKNode] = []
    var flyPath: [SKNode] = []
    private var towerPlaces: [SKShapeNode] = []
    private var towerMenu: TowerMenu?
    
    private var lastUpdateTime: TimeInterval = 0
    private var tapRecogniser: UITapGestureRecognizer?
    private var towerHandler: TowerHandler?
    var enemyHandler: EnemyHandler?
    var projectileHandler: ProjectileHandler?
    
    override func didMove(to view: SKView) {
        loadTileMap()
        loadWalkPath()
        loadFlyPath()
        loadTowerPlaces()
        tapRecogniser = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapRecogniser!)
        
        self.gameCam = self.childNode(withName: "gameCam") as? SKCameraNode
        self.camera = gameCam
        self.enemyHandler = EnemyHandler(gameScene: self)
        self.projectileHandler = ProjectileHandler(gameScene: self)
        self.towerHandler = TowerHandler(gameScene: self)
        
        enemyHandler?.makeAlien()
        enemyHandler?.makeCrab()
        enemyHandler?.makeWings()
        enemyHandler?.makeStomper()
        enemyHandler?.makeNerd()
        super.didMove(to: view)
        
    }
    
    
    func loadTileMap() {
        guard let tileMapNode = self.childNode(withName: "terrainMap") as? SKTileMapNode else {
            fatalError("Tile map node not found")
        }
        terrainMap = tileMapNode
    }
    
    func loadWalkPath() {
        walkPath = self["walkPath"]
        walkPath.sort { (node1, node2) in
            let waypoint1 = node1.userData?["waypoint"] as? Int ?? Int.max
            let waypoint2 = node2.userData?["waypoint"] as? Int ?? Int.max
            return waypoint1 < waypoint2
        }
    }
    
    func loadFlyPath() {
        flyPath = self["flyPath"]
        flyPath.sort { (node1, node2) in
            let waypoint1 = node1.userData?["waypoint"] as? Int ?? Int.max
            let waypoint2 = node2.userData?["waypoint"] as? Int ?? Int.max
            return waypoint1 < waypoint2
        }
    }
    
    func loadTowerPlaces() {
        towerPlaces = self["towerPlace"].compactMap { $0 as? SKShapeNode }
    }
    
    func getTowerPlaces() -> [SKShapeNode] {
        return towerPlaces
    }
        
    func touchDown(atPoint pos : CGPoint) {
            
    }
        
    func touchMoved(toPoint pos : CGPoint) {
            
    }
        
    func touchUp(atPoint pos : CGPoint) {
            
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        initialTouchLocation = touch.location(in: self)
    }
        
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            
    }
        
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
        
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            
    }
    
    // Remove tower menu once its served its function
    func clearTowerMenu() {
        towerMenu!.removeFromParent()
        towerMenu = nil
    }
    
    func handleTowerMenuButtonTap(button: TowerMenuButton) {
        let switcher = button.actionString
        if let menu = button.parent as? TowerMenu {
            let place = menu.place
            
            switch switcher {
            case "turret1":
                print("turret1 button pressed")
                towerHandler?.addTurretTower(at: place!, levelString: "turret1")
            case "turret2":
                towerHandler?.upgradeTower(at: place!)
            case "turret3":
                towerHandler?.upgradeTower(at: place!)
            case "missile1":
                towerHandler?.addMissileTower(at: place!, levelString: "missile1")
            case "missile2":
                towerHandler?.upgradeTower(at: place!)
            case "missile3":
                towerHandler?.upgradeTower(at: place!)
            case "delete":
                towerHandler?.deleteTower(at: place!)
            default:
                return
                
            }
        }
    }
        
    override func update(_ currentTime: TimeInterval) {
        
        // Called before each frame is rendered
        let deltaTime = currentTime - lastUpdateTime
        
        // Update the last update time to the current time
        lastUpdateTime = currentTime
        
        // Update enemies and towers
        enemyHandler?.updateEnemies(deltaTime: deltaTime)
        towerHandler?.update(deltaTime: deltaTime)
        projectileHandler?.update(deltaTime: deltaTime)
    }
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        
        let viewLocation = recognizer.location(in: self.view)        
        let sceneLocation = convertPoint(fromView: viewLocation)

        let touchedNode = atPoint(sceneLocation)
        
        // Check if a TowerMenu is active and if the tap is on one of its buttons
        if let towerMenu = towerMenu {
            for child in towerMenu.children {
                if let button = child as? TowerMenuButton {
                    let buttonLocation = convert(sceneLocation, to: towerMenu)
                    if button.contains(buttonLocation) {
                        print("Menu button pressed")
                        handleTowerMenuButtonTap(button: button)
                        clearTowerMenu()
                        return
                    }
                }
            }
            clearTowerMenu()
        }
        
        
        // Iteratre through buildable spaces
        if touchedNode is SKShapeNode {
            for place in towerPlaces {
                if place.contains(sceneLocation) {
                    // Check if the buildable space has no children, if not, call the initial menu
                    if place.children.isEmpty {
                        towerMenu = TowerMenu(menuType: "initial", place: place)
                        towerMenu!.position = sceneLocation
                        print("Initial menu made")
                        addChild(towerMenu!)
                    } else {
                        // If it does have children check what type of tower, call the relevant menu
                        for child in place.children {
                            if let tower = child as? TurretTower {
                                let towerType = tower.towerType
                                towerMenu = TowerMenu(menuType: towerType, place: place)
                                addChild(towerMenu!)
                            }
                        }

                    }
                   // towerHandler?.addTurretTower(at: place, levelString: "level1")
                   // break
                }
            }
        }
        
    }
        
}

