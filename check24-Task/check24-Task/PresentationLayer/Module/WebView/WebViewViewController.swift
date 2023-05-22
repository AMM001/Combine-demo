//
//  WebViewViewController.swift
//  check24-Task
//
//  Created by admin on 22/05/2023.
//

import UIKit
import WebKit


class WebViewViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
        if let url = URL(string: "https://m.check24.de/rechtliche-hinweise/?deviceoutput=app"){
            webView.load(URLRequest(url: url))
        }
        // 2
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
        // Do any additional setup after loading the view.
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}
