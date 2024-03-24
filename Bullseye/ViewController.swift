//
//  ViewController.swift
//  Bullseye
//
//  Created by Zeeshan Waheed on 16/03/2024.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var currentValue: Int = 50
//    var accuracyPercentage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//      customizing the slider
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
            
        
        // to play music as soon as the game starts
        playBGMusic()
        guessingNumber()
//        assignBackground()
        showAlert(self)
    }
    
    @IBOutlet weak var slider: UISlider!
    
    //  text label where the random number to guess is shown
    @IBOutlet var guessNumber: UILabel!
    
    //  variable to store guess number value as an integer
    var guessNum = 0
    
    //  text label where the score is displayed
    @IBOutlet var score: UILabel!
    
    //  score number for current round score
    var scoreNum = 0
    //  for sum of all score number
    var allScoreSum = 0
    
    //  text label for round number
    @IBOutlet var roundNum: UILabel!
    
    //  variable to store value of round numbe
    var roundNumber = 0
    
    //  a button to reset everthing
    @IBAction func startOverButton(_ sender: Any) {
        roundNumber = 1
        allScoreSum = 0
        displayResult()
        guessingNumber()
        slider.value = 50
//      for sound effect
        playButtonSound(buttonName: SystemButtonSound)
        
//      for transition effect
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name:
          CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
    }
    
//  hit me button status used for sound effect
    var hitmeHasBeenClicked = false
    
//  this will be used to play and stop music
    var musicStatus = true
    var audioPlayerForBG: AVAudioPlayer?
    var audioPlayerForHitMeButton: AVAudioPlayer?
    var audioPlayerForSystemButton: AVAudioPlayer?
    
//  variables for different sounds
    var backgroundMusicFile = "game-audio"
    var hitmeButtonSound = "hit-me button sound"
    var SystemButtonSound = "System Button click sound"

    
//  for button sound effect
    public func playButtonSound(buttonName: String) {
            guard let path1 = Bundle.main.path(forResource: buttonName, ofType:"mp3") else {
                return }
            let url1 = URL(fileURLWithPath: path1)
            
            do {
                if audioPlayerForSystemButton == nil {
                    audioPlayerForSystemButton = try AVAudioPlayer(contentsOf: url1)
                }
                audioPlayerForSystemButton?.play()
            } catch let error {
                print(error.localizedDescription)
            }
    }
    
    func playBGMusic() {
//      to play music if music Status variable is even
        if musicStatus == true {
            guard let path = Bundle.main.path(forResource: backgroundMusicFile, ofType:"mp3") else {
                return }
            let url = URL(fileURLWithPath: path)
            
            do {
                if audioPlayerForBG == nil {
                    audioPlayerForBG = try AVAudioPlayer(contentsOf: url)
                }
                audioPlayerForBG?.play()
                audioPlayerForBG?.numberOfLoops = -1
            } catch let error {
                print(error.localizedDescription)
            }
            musicStatus = false
        } else {
            print("")
        }
    }
    
    func stopBGMusic() {
        // to stop playing music
        audioPlayerForBG?.stop()
    }
    
//  this is what happens when the music toggle button is tapped
    @IBAction func musicToggle(_ sender: UISegmentedControl) {
        if musicStatus == true {
            playBGMusic()
            musicStatus = false
        } else {
            stopBGMusic()
            musicStatus = true
        }
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
//      resetting slider after each click
        slider.value = 50
        
//      This function has to be run atleast once for the guess value to be set
//      thats why we initially run it and while the hitmeHasBeenClicked variable is
//      set to false after the intial setup it is set to true
        if hitmeHasBeenClicked == true {
            guard let path1 = Bundle.main.path(forResource: hitmeButtonSound, ofType:"mp3") else {
                return }
            let url1 = URL(fileURLWithPath: path1)
            
            do {
                if audioPlayerForHitMeButton == nil {
                    audioPlayerForHitMeButton = try AVAudioPlayer(contentsOf: url1)
                }
                audioPlayerForHitMeButton?.play()
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        
        
//      incrementing round number after each click
        roundNumber += 1
        
//      formula for score
        scoreNum = 100 - abs(guessNum - currentValue)
        

        
//      to show title depending on score difference
        let difference = 100 - scoreNum
        let title: String
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "You almost had it!"
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
    //      variable to score all scores
            allScoreSum += scoreNum
        
        var accuracyPercentage: Double = 0.0
        if currentValue <= guessNum {
            accuracyPercentage = (Double(currentValue) / Double(guessNum) * 100)
        } else if currentValue > guessNum {
            accuracyPercentage = (Double(guessNum) / Double(currentValue) * 100)
        }
        print(accuracyPercentage)
//      an alert to display current round score
        let alert = UIAlertController(title: title, message: "Your slider was at \(currentValue) \nYour accuracy was \(lroundf(Float(accuracyPercentage)))% \nYou scored \(scoreNum) out of 100", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: { _ in self.guessingNumber()})
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        if hitmeHasBeenClicked == false {
            allScoreSum = 0
            displayResult()
        } else {
            displayResult()
        }
        hitmeHasBeenClicked = true
    }

//  this is used to save the value after slider is moved
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    @IBAction func infoButton(_ sender: Any) {
        playButtonSound(buttonName: SystemButtonSound)
    }
}


