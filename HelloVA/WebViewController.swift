//
//  WebViewController.swift
//  HelloVA
//
//  Created by Gonzalez Irigoyen, Guillermo on 6/18/19.
//  Copyright © 2019 Gonzalez Irigoyen, Guillermo. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebViewController : UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var currentUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadURL(currentUrl ?? URL(string: "https://fidelity.com")!)
        
    }
    
    func loadURL(_ url:URL){
        
        let request = URLRequest(url: url)
        webView.load(request)
        
    }
    
}
