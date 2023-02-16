//
//  GameViewController.swift
//  QuizGame
//
//  Created by Arthur Zamaraev on 10.02.2023.
//

import UIKit

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var gameModels = [Question]()
    
    var currentQuestion: Question?
    
    @IBOutlet var label: UILabel!
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        setupQuestions()
        configureUI(question: gameModels.first!)
    }

    private func configureUI(question: Question) {
        label.text = question.text
        currentQuestion = question
        table.reloadData()
    }
    
    private func checkAnswer(answer: Answer, question: Question) -> Bool {
        return question.answers.contains(where: { $0.text == answer.text }) && answer.correst
    }
    
    private func setupQuestions() {
        gameModels.append(Question(text: "What is 9 * 53", answers: [
            Answer(text: "240", correst: false),
            Answer(text: "477", correst: true),
            Answer(text: "310", correst: false),
            Answer(text: "467", correst: false)
        ]))
        
        gameModels.append(Question(text: "What is 24 * 36", answers: [
            Answer(text: "824", correst: false),
            Answer(text: "477", correst: false),
            Answer(text: "864", correst: true),
            Answer(text: "780", correst: false)
        ]))
        
        gameModels.append(Question(text: "What is 56 * 78", answers: [
            Answer(text: "4368", correst: true),
            Answer(text: "5677", correst: false),
            Answer(text: "3248", correst: false),
            Answer(text: "4658", correst: false)
        ]))
        
    }
    
    // Table view functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuestion?.answers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = currentQuestion?.answers[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let question = currentQuestion else {
            return
        }
        let answer = question.answers[indexPath.row]
        
        if checkAnswer(answer: answer, question: question) {
            // correct
            // [0, 1, 2] questions
            if let index = gameModels.firstIndex(where: { $0.text == question.text }) {
                if index < (gameModels.count - 1) {
                    // next question
                    let nextQuestion = gameModels[index+1]
                    print("\(nextQuestion.text)")
                    currentQuestion = nil
                    configureUI(question: nextQuestion)
                }
                else {
                    // end of game
                    let alert = UIAlertController(title: "Done", message: "You're the best", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:"Dismiss", style: .cancel, handler: nil))
                    present(alert, animated: true)
                }
            }
        }
        else {
            // wrong
            let alert = UIAlertController(title: "Wrong", message: "Try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }
    
}
    
    struct Question {
        let text: String
        let answers: [Answer]
    }
    
    struct Answer {
        let text: String
        let correst: Bool // true / false
    }
    
