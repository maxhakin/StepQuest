//
//  UIHandler.swift
//  StepQuest
//
//  Created by Max Hakin on 01/02/2024.
//

import Foundation
import UIKit

class UIHandler: UIViewController {

    // This is the variable you want to set with the user's input
    var gameStateHandler: GameStateHandler
    var gameScene: GameScene
    
    init (gameStateHandler: GameStateHandler, gameScene: GameScene) {
        self.gameStateHandler = gameStateHandler
        self.gameScene = gameScene
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup if needed
    }
    
    func makeTextInput() {
        // create the actual alert controller view that will be the pop-up
        let alertController = UIAlertController(title: "UserName", message: "Please enter your username", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            // configure the properties of the text field
            textField.placeholder = "UserName"
        }
        
        
        // add the buttons/actions to the view controller
        let saveAction = UIAlertAction(title: "Okay", style: .default) { _ in
            
            // this code runs when the user hits the "save" button
            
            let inputName = alertController.textFields![0].text
            
            self.gameStateHandler.userName = inputName!
            self.gameScene.setUserData()
            
            self.dismiss(animated: true)
            
        }
        
        alertController.addAction(saveAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func makeLeaderboards() {
        
    }
}
