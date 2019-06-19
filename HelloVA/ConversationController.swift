//
//  ViewController.swift
//  HelloVA
//
//  Created by Gonzalez Irigoyen, Guillermo on 6/14/19.
//  Copyright © 2019 Gonzalez Irigoyen, Guillermo. All rights reserved.
//

import UIKit


class ConversationController: UIViewController {

    
    /// IBOutlets - For UI
    @IBOutlet weak var conversationTable: UITableView!
    @IBOutlet weak var lookForAnswersBar: UISearchBar!
    
    /// Properties - Internal Data
    var conversationCellMessages = [ConversationMessage]()
    
    /// Identifiers
    let CONVERSATION_CELL_NIB_NAME   = "ConversationCell"
    let CONVERSATION_CELL_IDENTIFIER = "CONVERSATION_CELL"
    let WEB_VIEW_NIB_NAME            = "WebViewController"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Dont forget to set the class in Storyboard
        title = "Virtual Assistant"
        
        /// Examples
        loadExampleConversation()
        loadCCPS()
        
        /// Set delegates
        conversationTable.delegate   = self
        conversationTable.dataSource = self
        
        /// Register
        let conversationCell = UINib(nibName: CONVERSATION_CELL_NIB_NAME, bundle: .main)
        conversationTable.register(conversationCell, forCellReuseIdentifier: CONVERSATION_CELL_IDENTIFIER)
        
        lookForAnswersBar.delegate   = self
        
        print("Conversation View Did Load ....")
    }
    
}

/// MARK: - Helpers
extension ConversationController {
    
    /// Helpers
    func loadExampleConversation(){
        
        /// This is just and example, look in Conversation examples
        conversationExamples.append( userMessage000 )
        conversationExamples.append( assistantMessage000 )
        conversationExamples.append( userMessage001 )
        conversationExamples.append( assistantMessage001 )
        conversationExamples.append( assistantMessage002 )
        conversationExamples.append( assistantMessage003 )
        
        /// Conversation
        conversationCellMessages = conversationExamples
        
    }
    
    /// load CCPS
    func loadCCPS(){
        
        ccps["Hello Hi sup? you sup hey"] = "Hi there, what can I do for you?"
        ccps["how are you?"] = "I am doing well, what can I do for you?"
        ccps["Account Details money checks transfer"]  = "Your total Balance is ... $103.00"
        ccps["Edit my info contact broker"] = "for that you will have to Log in"
        
        ccps["GO-TO-KEYS"]  = "Edit my info contact broker"
        ccps["GO-TO-LOGIN"] = "https://login.fidelity.com/ftgw/Fidelity/RtlCust/Login/Init/df.chf.ra/trial"
        
    }
    
    
    /// Conversation Memory
    func addToConversation(message: ConversationMessage, isUser user:Bool = false){
        
        conversationCellMessages.append(message)
        
        if user {
            thinkAboutThis(utterances: message.message)
        }
        
        conversationTable.reloadData()
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.conversationCellMessages.count-1, section:0)
            self.conversationTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
        
    }
    
    /// CCP
    func thinkAboutThis(utterances: String){
        
        /// Totally not the must efficient way to do it but nice for example, gives the thinking time for anymations and simulation
        /// This is backend oriented too so no prob
        /// I am truly sorry about efficency lol
        
        var answerFound = false
        let keys = ccps.keys
        var instructionString = ""
        let gotoString = ccps["GO-TO-KEYS"]?.lowercased()
        
        
        for instruction in keys {
            instructionString = instruction.lowercased()
            
            for utterance in utterances.lowercased().split(separator: " ") {
                
                if instructionString.contains(utterance) && utterance.count > 1 && answerFound == false {
                    
                    answerFound = true

                    let assitantConversationMessage = ConversationMessage(side: .assistant, withMessage: ccps[instruction]!)
                    addToConversation(message: assitantConversationMessage)
                    
                    if gotoString == instructionString {
                        
                        let assitantConversationActionMessage = ConversationMessage(side: .assistant, withMessage: "Go to your account", andAction:true)
                        addToConversation(message: assitantConversationActionMessage)
                        
                    }
                    
                    
                } else if utterance.count < 2  && answerFound == false {
                    
                    answerFound = true
                    let assitantConversationMessage = ConversationMessage(side: .assistant, withMessage: "I am not sure I understand what you're asking")
                    addToConversation(message: assitantConversationMessage)
                    
                }
                
            }
            
        }
        
        if answerFound == false {
        
            let assitantConversationMessage = ConversationMessage(side: .assistant, withMessage: "I am not sure I understand what you're asking")
            addToConversation(message: assitantConversationMessage)
            
        }
        
        
    }
    
}




/// MARK: - Table View Delegate
extension ConversationController: UITableViewDelegate, UITableViewDataSource {
    
    /// Table Bar Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversationCellMessages.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CONVERSATION_CELL_IDENTIFIER, for: indexPath) as! ConversationCell
        
        let message = conversationCellMessages[indexPath.item]
        
        if message.action {
            cell.updateCelllFor(type: message.type, withMessage: message.message, andAction: true)
            cell.assitantActionButton.addTarget(self, action: #selector(goTo(_:)), for: .touchUpInside)
            
        } else {
            cell.updateCelllFor(type: message.type, withMessage: message.message, andAction: false)
            
        }
        
        return cell
    }
    
}


/// MARK: - Search Bar View Controller Delegate
extension ConversationController: UISearchBarDelegate {
    
    /// Search Bar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let searchText = searchBar.text
        if searchText != nil {
            
            let userConversationMessage = ConversationMessage(side: .user, withMessage: searchText!)
            
            addToConversation(message: userConversationMessage, isUser: true)
            
            searchBar.text = ""
            view.endEditing(true)
            
        }
        
    }
    
}


/// MARK: -helpers
extension ConversationController {
    
    @objc func goTo(_ sender:Any){
        
        let webViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: WEB_VIEW_NIB_NAME) as! WebViewController
        webViewController.currentUrl = URL(string: ccps["GO-TO-LOGIN"]!)!
        
        show(webViewController, sender: self)
        
    }
    
}
