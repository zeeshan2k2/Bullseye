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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // to play music as soon as the game starts
        playBGMusic()
        assignBackground()
        showAlert(self)
    }
    
//  function to assign a background image
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
    
    //  variable to store value of round numbe
    var roundNumber = 1
    
    //  a button to reset everthing
    @IBAction func startOverButton(_ sender: Any) {
        roundNumber = 1
        allScoreSum = 0
        displayResult()
        guessingNumber()
        
//      for sound effect
        guard let newSound = Bundle.main.path(forResource: startOverButtonSound, ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: newSound)
        
        do {
            if audioPlayerForStartOverButton == nil {
                audioPlayerForStartOverButton = try AVAudioPlayer(contentsOf: url)
            }
            audioPlayerForStartOverButton?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
//  hit me button status used for sound effect
    var hitmeHasBeenClicked = false
    
//  this will be used to play and stop music
    var musicStatus = true
    var audioPlayerForBG: AVAudioPlayer?
    var audioPlayerForHitmeButton: AVAudioPlayer?
    var audioPlayerForStartOverButton: AVAudioPlayer?
    
//  variables for different sounds
    var backgroundMusicFile = "game-audio"
    var hitmeButtonSound = "hit-me button sound"
    var startOverButtonSound = "Start Over button click sound"

    
    
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
//                audioPlayer?.numberOfLoops = -1
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
        
//      This function has to be run atleast once for the guess value to be set
//      thats why we initially run it and while the hitmeHasBeenClicked variable is
//      set to false after the intial setup it is set to true
        if hitmeHasBeenClicked == true {
            //      to play the button click sound
            guard let newSound = Bundle.main.path(forResource: hitmeButtonSound, ofType:"mp3") else {
                return }
            let url = URL(fileURLWithPath: newSound)
            
            do {
                if audioPlayerForHitmeButton == nil {
                    audioPlayerForHitmeButton = try AVAudioPlayer(contentsOf: url)
                }
                audioPlayerForHitmeButton?.play()
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        hitmeHasBeenClicked = true
        
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


