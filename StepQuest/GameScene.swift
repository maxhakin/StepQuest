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
        print("Tap handled")
        
        let viewLocation = recognizer.location(in: self.view)        
        let sceneLocation = convertPoint(fromView: viewLocation)

        let touchedNode = atPoint(sceneLocation)

        if touchedNode is SKShapeNode {
            for place in towerPlaces {
                    if place.contains(sceneLocation) {
                        
                        towerHandler?.addTurretTower(at: place, levelString: "level1")
                        break
                        }
                    }
        }
        
        }
        
    }

