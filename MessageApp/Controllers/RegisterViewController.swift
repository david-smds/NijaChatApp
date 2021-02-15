//
//  RegisterViewController.swift
//  MessageApp
//
//  Created by Dawid Sędzimir on 09/02/2021.
//

import UIKit
import CLTypingLabel
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var appNameLabel: CLTypingLabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var swipeLabel: UISwipeGestureRecognizer!
    
    @IBOutlet weak var errorLabelText: UILabel!
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
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.errorLabelText.text = e.localizedDescription
                    //self.performSegue(withIdentifier: "goForError", sender: self)
                }
            else {
            self.performSegue(withIdentifier: "RegisterSucceed", sender: self)
            }
        }
    }
   
}
    
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //     if segue.identifier == "goForError" {
        //       let destinationVC = segue.destination as! PopUpViewController
          //  destinationVC.errorText =
           //}
       //}
}
