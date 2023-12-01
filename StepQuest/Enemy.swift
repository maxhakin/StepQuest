//
//  Enemy.swift
//  StepQuest
//
//  Created by Louis Kürbis on 29/11/2023.
//

import Foundation
import SpriteKit
import GameplayKit

class Enemy: SKSpriteNode {
    var imageFile: String = "monster101"
    var health: Int = 100
    var moveSpeed: Float = 12.0
    var currentWaypoint: GKGraphNode?
    var currentPosition: CGPoint?
    var pathGraph: GKGraph
    var currentNodeIndex: Int = 0
    var path: [GKGraphNode]?

    
    init(graph: GKGraph) {
        let texture = SKTexture(imageNamed: imageFile)
        self.pathGraph = graph
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        findPath()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func takeDamage() {
        
    }
    
    func die() {
        
    }
    
    func initPos() {
        
    }
    
    func findPath() {
        if let allNodes = pathGraph.nodes as? [GKGraphNode2D] {
            let startNode = allNodes.max(by: { $0.position.y < $1.position.y })
            let endNode = allNodes.min(by: { $0.position.y < $1.position.y })
            
            if let startNode = startNode, let endNode = endNode {
                let path = pathGraph.findPath(from: startNode, to: endNode) as? [GKGraphNode2D]
            }
        }
    }
}
