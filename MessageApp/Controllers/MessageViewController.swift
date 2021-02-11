//
//  MessageViewController.swift
//  MessageApp
//
//  Created by Dawid Sędzimir on 09/02/2021.
//

import UIKit
import Firebase

class MessageViewController: UIViewController {

    @IBOutlet var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [MessageModel] = [
        MessageModel(sender: "1@9.com", body: "Hey Babe!"),
        MessageModel(sender: "1@2.com", body: "Hey sweetey, how u doin?"),
        MessageModel(sender: "1@9.com", body: "I'm great, what abt U?"),
        MessageModel(sender: "1@2.com", body: "Also fantastic. bla bla bla bla bla blablab sjhba hjsajhcz bsafjhgasjf jsfbzkdvb  skjbvxzjvb xkzvjcbsdk dvsakjasah askjfhaskhowe cskjgsiv")
    ]
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        title = "🥷NINJCHAT"
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: "MessageCellTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
    }
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
        
        navigationController?.popToRootViewController(animated: true)
        
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
        }
      
    }
}

extension MessageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
            as! MessageCellTableViewCell
        cell.label.text = messages[indexPath.row].body
        return cell
    }
    
    
}
