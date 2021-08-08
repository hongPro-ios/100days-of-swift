//
//  WebViewController.swift
//  Project16
//
//  Created by JEONGSEOB HONG on 2021/08/08.
//


import UIKit
import WebKit

class WebViewController: UIViewController {
    var webView: WKWebView!
    var url: URL
    
    init(url: URL) {
        self.url = url
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
}

extension WebViewController: WKNavigationDelegate {
    
}
