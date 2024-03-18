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
        assignBackground()
        showAlert(self)
    }

    
    func assignBackground() {
        let background = UIImage(named: "Bullseye bg image.jpeg")

        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
//  text label where the random number to guess is shown
    @IBOutlet var guessNumber: UILabel!
    
//  variable to store guess number value as an integer
    var guessNum = 0
    
//  text label where the score is displayed
    @IBOutlet var score: UILabel!
    
//  score number for current round score
    var scoreNum = 0
//  for sum of all score number
    var allScoreSum = -50
    
//  text label for round number
    @IBOutlet var roundNum: UILabel!
    
//  variable to store value of round number
    var roundNumber = 0
    
//  a button to reset everthing
    @IBAction func startOverButton(_ sender: Any) {
        roundNumber = 0
        allScoreSum = 0
        displayResult()
        guessingNumber()
    }
    
//  function to create a random number and sent it to text label associated with guess number
    func guessingNumber() -> Int {
        guessNum = Int.random(in: 1...100)
        guessNumber.text = String(guessNum)
        return guessNum
    }
    
//  function that displays total score and round number
    func displayResult() {
        score.text = String(allScoreSum)
        roundNum.text = String(roundNumber)
    }
    
//  function when hit me button is tapped
    @IBAction func showAlert(_ sender: Any) {
        
//      incrementing round number after each click
        roundNumber += 1
        
//      formula for score
        scoreNum = 100 - abs(guessNum - currentValue)
        
//      variable to score all scores
        allScoreSum += scoreNum
        
        
//      showing the value if current slider position
        let message = "The value of current slider is: \(currentValue)"
        
//      an alert to display current round score
        let alert = UIAlertController(title: "Your score is \(scoreNum)", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        displayResult()
        guessNum = guessingNumber()
        
    }

//  this is used to save the value after slider is moved
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
}

