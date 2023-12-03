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
    private var walkPath: [SKNode] = []
    private var enemy: Enemy?
    private var lastUpdateTime: TimeInterval = 0
    
    override func didMove(to view: SKView) {
        loadTileMap()
        loadWalkPath()
        self.enemy = Enemy(path: walkPath)
        addChild(self.enemy!)
        self.gameCam = self.childNode(withName: "gameCam") as? SKCameraNode
        self.camera = gameCam
        
        super.didMove(to: view)
        
    }
    
    
    func loadTileMap() {
        guard let tileMapNode = self.childNode(withName: "terrainMap") as? SKTileMapNode else {
            fatalError("Tile map node not found")
        }
        terrainMap = tileMapNode
    }
    
    func loadWalkPath() {
        // Temporary array to hold nodes and their order values
        var nodesWithOrder: [(node: SKNode, order: Int)] = []
        
        walkPath = self["walkPath"]
        walkPath.sort { (node1, node2) in
            let waypoint1 = node1.userData?["waypoint"] as? Int ?? Int.max
            let waypoint2 = node2.userData?["waypoint"] as? Int ?? Int.max
            return waypoint1 < waypoint2
        }
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
        guard let touch = touches.first, let startLocation = initialTouchLocation else {return}
        let endLocation = touch.location(in: self)
            
        //if isTap(at: startLocation, endLocation: endLocation) {
        //   inputHandler.
        //}
    }
        
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            
    }
        
        
    override func update(_ currentTime: TimeInterval) {
        print("updating")
        
        // Called before each frame is rendered
        let deltaTime = currentTime - lastUpdateTime
        
        // Update the last update time to the current time
        lastUpdateTime = currentTime
        
        // Call the move function with deltaTime
        enemy?.move(deltaTime: deltaTime)
    }
}
