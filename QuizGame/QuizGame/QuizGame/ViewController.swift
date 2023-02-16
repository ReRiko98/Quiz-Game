//
//  ViewController.swift
//  QuizGame
//
//  Created by Arthur Zamaraev on 09.02.2023.
/*
 Things we need
 - Menu screeen
 - Game screen
 - Answer object
 - Question object
 */






import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startGame() {
        let vc = storyboard?.instantiateViewController(identifier: "game") as! GameViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }


}

