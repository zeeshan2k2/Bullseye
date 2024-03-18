//
//  ViewController.swift
//  Bullseye
//
//  Created by Zeeshan Waheed on 16/03/2024.
//

import UIKit

class ViewController: UIViewController {

    var currentValue: Int = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showAlert(self)
        scoreNumber.text = "0"
    }

    @IBOutlet var guessNumber: UILabel!
    
    var guessNum = 0
    
    @IBOutlet var score: UILabel!
    
    var scoreNum = 0
    var allScoreSum = -50
    
    @IBOutlet var scoreNumber: UILabel!
    
    @IBOutlet var roundNum: UILabel!
    
    var roundNumber = 0
    
    @IBAction func startOverButton(_ sender: Any) {
        roundNumber = 0
        allScoreSum = 0
        displayResult()
        guessingNumber()
    }
    
    func guessingNumber() -> Int {
        guessNum = Int.random(in: 1...100)
        guessNumber.text = String(guessNum)
        return guessNum
    }
    
    func displayResult() {
        score.text = String(scoreNum)
        scoreNumber.text = String(allScoreSum)
        roundNum.text = String(roundNumber)
    }
    
    @IBAction func showAlert(_ sender: Any) {
        
        roundNumber += 1
        
        scoreNum = 100 - abs(guessNum - currentValue)
        allScoreSum += scoreNum
        
        
        let message = "The value of current slider is: \(currentValue)"
        
        let alert = UIAlertController(title: "Your score is \(scoreNum)", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        displayResult()
        guessNum = guessingNumber()
        
    }

    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
}

