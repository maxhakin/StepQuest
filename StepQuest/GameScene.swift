//
//  GameScene.swift
//  StepQuest
//
//  Created by Max Hakin on 27/11/2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var inputHandler: InputHandler!
    private var initialTouchLocation: CGPoint?
    private var tileMap: SKTileMapNode?
    private var gameCam: SKCameraNode?
    
    override func didMove(to view: SKView) {
        
        self.gameCam = SKCameraNode()
        self.addChild(gameCam!)
        self.camera = gameCam

        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        view.addGestureRecognizer(pinchGesture)
        super.didMove(to: view)
        loadTileMap()
        
    }
    
    func loadTileMap() {
        guard let tileMapNode = self.childNode(withName: "terrainMap") as? SKTileMapNode else {
                    fatalError("Tile map node not found")
                }
                tileMap = tileMapNode
    }
    
    @objc func handlePinch(_ sender: UIPinchGestureRecognizer) {
            guard let camera = gameCam else { return }

            if sender.state == .changed {
                let scale = 1 / sender.scale
                camera.setScale(camera.xScale * scale)
                sender.scale = 1.0

                // Add logic here to clamp the camera's scale to prevent over-zooming
            }
    }
    
    func clampCameraScale() {
        guard let camera = gameCam else { return }
        let minScale: CGFloat = 1.0 // Minimum zoom level
        let maxScale: CGFloat = 2.0 // Maximum zoom level

        camera.xScale = max(minScale, min(camera.xScale, maxScale))
        camera.yScale = camera.xScale // Keep the scale uniform
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
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
