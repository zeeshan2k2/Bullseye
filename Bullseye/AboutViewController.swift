//
//  AboutViewController.swift
//  Bullseye
//
//  Created by Zeeshan Waheed on 23/03/2024.
//

import UIKit
import WebKit
import AVFAudio
import Foundation


class AboutViewController: UIViewController, UIWebViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = Bundle.main.url(forResource: "BullsEye", withExtension: "html"){
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    


    @IBOutlet var webView: WKWebView!
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
