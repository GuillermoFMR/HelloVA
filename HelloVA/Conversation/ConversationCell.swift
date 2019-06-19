//
//  ConversationCell.swift
//  HelloVA
//
//  Created by Gonzalez Irigoyen, Guillermo on 6/17/19.
//  Copyright © 2019 Gonzalez Irigoyen, Guillermo. All rights reserved.
//

import UIKit

class ConversationCell: UITableViewCell {
    
    @IBOutlet weak var userIconView: UIView!
    @IBOutlet weak var assistantIconView: UIView!
    
    @IBOutlet weak var userMessageLabel: UILabel!
    @IBOutlet weak var assitantMessageLabel: UILabel!
    
    @IBOutlet weak var assitantActionButton: UIButton!
    
    /// Helpers
    func updateCelllFor(type aType: ConversationSide, withMessage message:String, andAction action:Bool){
        
        switch aType {
        case .user:
            userIconView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            userMessageLabel.text = message
            
            /// Clean Assistant
            assistantIconView.backgroundColor = .clear
            assitantMessageLabel.text = ""
            
        case .assistant:
            
            if action {
                assitantActionButton.isEnabled = action
                assitantActionButton.setTitle(message, for: .normal)
                
                assistantIconView.backgroundColor = .clear
                assitantMessageLabel.text = ""
                
            } else {
                assistantIconView.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
                assitantMessageLabel.text = message
                
                /// Clean User
                userIconView.backgroundColor = .clear
                userMessageLabel.text = ""
            }
        }
        
    }
    
}


