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
    }


    @IBAction func showAlert(_ sender: Any) {
        let message = "The value of current slider is: \(currentValue)"
        
        let alert = UIAlertController(title: "Hello World!", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }

    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
}

