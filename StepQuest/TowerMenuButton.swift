//
//  TowerMenuButton.swift
//  StepQuest
//
//  Created by Max Hakin on 13/12/2023.
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
        
        // Set Button image to that of a tower
        self.buttonImage = SKSpriteNode(texture: texture)
        self.buttonImage.size = CGSize(width: 180, height: 180)
        // Position the image above the center
        self.buttonImage.position = CGPoint(x: 0, y: 10)
        
        //Format button text
        self.buttonText = SKLabelNode(text: buttonText)
        self.buttonText.fontName = "Arial"
        self.buttonText.fontSize = 30
        self.buttonText.fontColor = SKColor.white
        self.buttonText.verticalAlignmentMode = .center
        // Position the text below the image
        self.buttonText.position = CGPoint(x: 0, y: -80)
        
        super.init(texture: nil, color: .lightGray, size: buttonSize)
        
        // Set Z position so button is drawn in front of other graphics
        zPosition = 5
        
        // Add the image and text as children
        addChild(self.buttonImage)
        addChild(self.buttonText)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
