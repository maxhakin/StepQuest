//
//  UIHandler.swift
//  StepQuest
//
//  Created by Max Hakin on 01/02/2024.
//

import Foundation
import UIKit

class UIHandler: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // Variables for game state and scene
    var gameStateHandler: GameStateHandler
    var gameScene: GameScene
    var leaderboardData: [LeaderboardEntry] = [] // Placeholder for leaderboard data
    
    // TableView property declaration
    private var tableView: UITableView!

    // Initializer
    init(gameStateHandler: GameStateHandler, gameScene: GameScene) {
        self.gameStateHandler = gameStateHandler
        self.gameScene = gameScene
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Call setupLeaderboardPopup() to setup and display the leaderboard popup
        // setupLeaderboardPopup() // Uncomment this if you want to show the popup automatically
    }
    
    // Function to create and present a text input alert
    func makeTextInput() {
        let alertController = UIAlertController(title: "UserName", message: "Please enter your username", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "UserName"
        }
        
        let saveAction = UIAlertAction(title: "Okay", style: .default) { _ in
            let inputName = alertController.textFields![0].text
            self.gameStateHandler.userName = inputName!
            self.gameScene.setUserData()
            self.dismiss(animated: true)
        }
        
        alertController.addAction(saveAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // Setup and display the leaderboard popup
    func setupLeaderboardPopup(data: [LeaderboardEntry]) {
        leaderboardData = data
        let backgroundView = UIView(frame: self.view.bounds)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.addSubview(backgroundView)

        tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = true
        tableView.layer.cornerRadius = 12
        backgroundView.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            tableView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8),
            tableView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.6)
        ])

        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(dismissLeaderboardPopup), for: .touchUpInside)
        backgroundView.addSubview(closeButton)

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            closeButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 100),
            closeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // Dismiss the leaderboard popup
    @objc private func dismissLeaderboardPopup() {
        self.view.subviews.last?.removeFromSuperview()
        self.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboardData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let entry = leaderboardData[indexPath.row]
        cell.textLabel?.text = "\(indexPath.row + 1). \(entry.userName) - Level: \(entry.highLevel) - Steps: \(entry.totalSteps)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Rankings"
    }
}
