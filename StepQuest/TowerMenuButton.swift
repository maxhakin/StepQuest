//
//  TowerMenuButton.swift
//  StepQuest
//
//  Created by Louis Kürbis on 13/12/2023.
//

import Foundation
import SpriteKit

class TowerMenuButton: SKSpriteNode {
    private var buttonImage: SKSpriteNode
    private var buttonText: SKLabelNode
    
    init(buttonImage: String, buttonText: String) {
        let buttonSize = CGSize(width: 50.0, height: 50.0)
        
        self.buttonImage = SKSpriteNode(fileNamed: buttonImage)!
        self.buttonImage.size = CGSize(width: 50, height: 50) // Set your desired size
        self.buttonImage.position = CGPoint(x: 0, y: 30) // Position the image above the center
        
        self.buttonText = SKLabelNode(text: buttonText)
        self.buttonText.fontName = "Arial"
        self.buttonText.fontSize = 12
        self.buttonText.fontColor = SKColor.white
        self.buttonText.verticalAlignmentMode = .center
        self.buttonText.position = CGPoint(x: 0, y: -10) // Position the text below the image
        
        super.init(texture: nil, color: .blue, size: buttonSize)
        
        // Add the image and text as children
        addChild(self.buttonImage)
        addChild(self.buttonText)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
