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
    private var tileMap: SKTileMapNode?
    private var gameCam: SKCameraNode?
    private var walkPath: GKGraph?
    private var enemy: Enemy?
    
    override func didMove(to view: SKView) {
        loadTileMap()
        loadWalkPath()
        let enemy = Enemy(graph: walkPath ?? <#default value#>)
        
        self.gameCam = self.childNode(withName: "gameCam") as? SKCameraNode
        self.camera = gameCam

        super.didMove(to: view)
        
    }
    
    
    func loadTileMap() {
        guard let tileMapNode = self.childNode(withName: "terrainMap") as? SKTileMapNode else {
                    fatalError("Tile map node not found")
                }
                tileMap = tileMapNode
    }
    
    func loadWalkPath() {
        guard let walkGraph = self.childNode(withName: "walkPath") as? GKGraph else {
                    fatalError("Navigation graph not found")
                }
                walkPath = walkGraph
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
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let startLocation = initialTouchLocation else {return}
        let endLocation = touch.location(in: self)
        
        //if isTap(at: startLocation, endLocation: endLocation) {
         //   inputHandler.
        //}
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
