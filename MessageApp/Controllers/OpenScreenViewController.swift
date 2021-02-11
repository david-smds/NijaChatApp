//
//  ViewController.swift
//  MessageApp
//
//  Created by Dawid Sędzimir on 05/02/2021.
//

import UIKit
import CLTypingLabel

class ViewController: UIViewController {

    @IBOutlet weak var chatNameLabel: CLTypingLabel!
    @IBOutlet weak var loginButtonLabel: UIButton!
    @IBOutlet weak var registerButtonLabel: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatNameLabel.text = "🥷NINJCHAT"
        
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
    }
    
    
}

