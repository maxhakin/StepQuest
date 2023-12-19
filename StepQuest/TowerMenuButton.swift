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
    var actionString: String
    
    init(texture: SKTexture, buttonText: String, actionString: String) {
        let buttonSize = CGSize(width: 200, height: 200)
        self.actionString = actionString
        
        self.buttonImage = SKSpriteNode(texture: texture)
        self.buttonImage.size = CGSize(width: 180, height: 180) // Set your desired size
        self.buttonImage.position = CGPoint(x: 0, y: 10) // Position the image above the center
        
        self.buttonText = SKLabelNode(text: buttonText)
        self.buttonText.fontName = "Arial"
        self.buttonText.fontSize = 30
        self.buttonText.fontColor = SKColor.white
        self.buttonText.verticalAlignmentMode = .center
        self.buttonText.position = CGPoint(x: 0, y: -80) // Position the text below the image
        
        super.init(texture: nil, color: .lightGray, size: buttonSize)
        //alpha = 0.5
        
        zPosition = 5
        
        // Add the image and text as children
        addChild(self.buttonImage)
        addChild(self.buttonText)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
