//
//  LoginViewController.swift
//  MessageApp
//
//  Created by Dawid Sędzimir on 09/02/2021.
//

import UIKit
import Firebase
import CLTypingLabel
import NotificationBannerSwift

class LoginViewController: UIViewController {

    @IBOutlet var swipeGestureLabel: UISwipeGestureRecognizer!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var appNameLabel: CLTypingLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appNameLabel.text = "🥷NINJCHAT"
        title = "🥷NINJCHAT"
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipe.direction = .right
        view.addGestureRecognizer(swipe)
        
    }
  
    @objc func handleSwipe(_ sender:UISwipeGestureRecognizer) {
           if sender.direction == .right {
               self.dismiss(animated: true, completion: nil)
           }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                
                let banner = NotificationBanner(title: "Error", subtitle: e.localizedDescription, style: .danger)
                  banner.show(bannerPosition: .top)
                  banner.onSwipeUp = {
                      banner.isHidden = true
                  }
                //self.errorLabel.text = e.localizedDescription
            } else {
                self.performSegue(withIdentifier: "LoginSucceed", sender: self)
                }
            }
        }
    }
    
    
}
 
