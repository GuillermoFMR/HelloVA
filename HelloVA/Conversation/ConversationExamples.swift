//
//  ConversationExamples.swift
//  HelloVA
//
//  Created by Gonzalez Irigoyen, Guillermo on 6/17/19.
//  Copyright © 2019 Gonzalez Irigoyen, Guillermo. All rights reserved.
//

import Foundation



var conversationExamples = [ConversationMessage]()

var userMessage000 = ConversationMessage(side: .user, withMessage: "Hello there")
var assistantMessage000 = ConversationMessage(side: .assistant, withMessage: "Hi, what can I do for you today?")
var userMessage001 = ConversationMessage(side: .user, withMessage: "How is my account?")
var assistantMessage001 = ConversationMessage(side: .assistant, withMessage: "Your Investments are paying")
var assistantMessage002 = ConversationMessage(side: .assistant, withMessage: "APPL +3.0% ... $103.00")
var assistantMessage003 = ConversationMessage(side: .assistant, withMessage: "Your total balance ... $103.00")

var ccps = [String:String]()

