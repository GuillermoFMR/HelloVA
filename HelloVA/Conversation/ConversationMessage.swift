//
//  ConversationMessage.swift
//  HelloVA
//
//  Created by Gonzalez Irigoyen, Guillermo on 6/17/19.
//  Copyright © 2019 Gonzalez Irigoyen, Guillermo. All rights reserved.
//

import Foundation


enum ConversationSide {
    case user
    case assistant
    
}

/// *Talk about structs but keep Class for simplixity of examples

class ConversationMessage {
    
    /// Properties
    let type: ConversationSide!
    let message: String!
    var action: Bool!
    
    /// Initializers
    init(side aSide:ConversationSide, withMessage aMessage:String, andAction action:Bool = false){
        
        self.type = aSide
        self.message = aMessage
        self.action = action
        
    }
    
}

