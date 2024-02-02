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
    
    func makeLeaderboards(data: [LeaderboardEntry]) {
        // Initialize the alert controller to present the leaderboard
        let alertController = UIAlertController(title: "Leaderboard", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
           
        // Create a UITextView to display the leaderboard entries
        let textView = UITextView(frame: CGRect.zero)
        textView.isUserInteractionEnabled = false // Disable user interaction
        textView.backgroundColor = .clear // Optional: make the background clear
           
        // Populate the UITextView with the leaderboard data
        var leaderboardText = ""
        var rank = 1
        for entry in data {
            leaderboardText += "\(rank): \(entry.userName): \(entry.highLevel): \(entry.totalSteps)\n"
            rank+=1
        }
        textView.text = leaderboardText
           
        // Add the UITextView to the alert controller's view
        alertController.view.addSubview(textView)
           
        // Constraints for the UITextView
        textView.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = NSLayoutConstraint(item: textView, attribute: .leading, relatedBy: .equal, toItem: alertController.view, attribute: .leadingMargin, multiplier: 1.0, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: textView, attribute: .trailing, relatedBy: .equal, toItem: alertController.view, attribute: .trailingMargin, multiplier: 1.0, constant: 0)
        let topConstraint = NSLayoutConstraint(item: textView, attribute: .top, relatedBy: .equal, toItem: alertController.view, attribute: .top, multiplier: 1.0, constant: 45)
        let bottomConstraint = NSLayoutConstraint(item: textView, attribute: .bottom, relatedBy: .equal, toItem: alertController.view, attribute: .bottom, multiplier: 1.0, constant: -45)
        alertController.view.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
           
        // Add an 'OK' action to dismiss the alert
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
           
        // Present the alert controller
        self.present(alertController, animated: true)
    }
}
