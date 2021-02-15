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
    
    let db = Firestore.firestore()
    
    var messages: [MessageModel] = []
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        title = "🥷NINJCHAT"
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: "MessageCellTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        loadMessages()
        
    }
    
    func loadMessages() {
        
       
        
        db.collection("messages")
            .order(by: "time")
            .addSnapshotListener { (querySnapshot, error) in
            
            self.messages = []
            
            if let err = error {
                print("Retrieving data gone wrong. \(err)")
            } else {
                if let snapDocs = querySnapshot?.documents {
                    for doc in snapDocs {
                        let data = doc.data()
                        if let messageSender = data["sender"] as? String, let messageBody = data["body"] as? String {
                            let newMessage = MessageModel(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                
                                let indexPath = IndexPath.init(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func sendMessagePressed(_ sender: UIButton) {
        
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection("messages").addDocument(data: [
                "sender": messageSender,
                "body": messageBody,
                "time": Date().timeIntervalSince1970
            ]) { (error) in
                if let err = error {
                    print("Something wrong happend \(err)")
                } else {
                    print("Everything is fine.")
                }
            }
        }
        messageTextField.text = ""
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
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
            as! MessageCellTableViewCell
        cell.label.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftSideImage.isHidden = true
            cell.rightSideImage.isHidden = false
            cell.messageBubble.backgroundColor = #colorLiteral(red: 0.915623188, green: 0.6242504716, blue: 0.5213937759, alpha: 1)
        } else {
            cell.leftSideImage.isHidden = false
            cell.rightSideImage.isHidden = true
            cell.messageBubble.backgroundColor = #colorLiteral(red: 0.9093078375, green: 0.7622211576, blue: 0.4598796964, alpha: 1)
        }
        
        
        return cell
    }
    
    
}
