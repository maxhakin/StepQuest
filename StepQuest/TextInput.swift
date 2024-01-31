//
//  TextInput.swift
//  StepQuest
//
//  Created by Max Hakin on 31/01/2024.
//

import Foundation
import UIKit

class TextInput: UIViewController {

    // This is the variable you want to set with the user's input
    var userInput: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup if needed
    }

    func presentInputAlert() {
        // Create the alert controller
        let alert = UIAlertController(title: "Input Needed", message: "Please enter some text", preferredStyle: .alert)

        // Add a text field to the alert
        alert.addTextField { textField in
            textField.placeholder = "Enter your text here"
        }

        // Add an 'OK' action to the alert
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self, weak alert] _ in
            // Capture the text field input and set the variable
            let textField = alert?.textFields?[0]
            self?.userInput = textField?.text
            // Optionally, do something with the user's input here
        }

        alert.addAction(okAction)

        // Present the alert
        self.present(alert, animated: true, completion: nil)
    }

    // Function to be called when you want to show the alert
    func showInputPopup() {
        presentInputAlert()
    }
}
