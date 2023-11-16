//
//  BusinessBrowserViewController.swift
//  restaurant-explorer-yelp
//
//  Created by Miguel Mañas Alvarez on 14/11/23.
//

import UIKit
import WebKit

class BusinessBrowserViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var webView: WKWebView!
    
    let businessURL: URL!
    let businessName: String!
    
    init(businessName: String, businessURL: URL) {
        self.businessName = businessName
        self.businessURL = businessURL
        super.init(nibName: "BusinessBrowserViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = businessName
        webView.load(URLRequest(url: businessURL))
        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
       }

       override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
           if keyPath == "estimatedProgress" {
               if self.webView.estimatedProgress >= 1.0 {
                   self.progressView.isHidden = true
               } else {
                   self.progressView.progress = Float(self.webView.estimatedProgress)
               }
           }
       }

}
