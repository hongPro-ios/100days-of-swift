//
//  ViewController.swift
//  Project4
//
//  Created by JEONGSEOB HONG on 2021/07/02.
//

import UIKit
import WebKit


class WebViewController: UIViewController {
    var webView: WKWebView!
    var progressView: UIProgressView!
    var initSite: Site
    
    init(initSite: Site) {
        self.initSite = initSite
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
        
        setupUI()
        setupUX()
        initOpenPage()
    }
    
    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?
    ) {
        if keyPath == "estimatedProgress" {
            print(Float(webView.estimatedProgress))
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page", message: nil, preferredStyle: .actionSheet)
        
        for website in Site.allCases {
            ac.addAction(UIAlertAction(title: website.url, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "ttest", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
        
    }
    
    func openPage(action: UIAlertAction) {
        guard
            let actionTitle = action.title,
            let url = URL(string: "https://" + actionTitle)
        else { return }
        
        webView.load(URLRequest(url: url))
    }
    
    func setupUI() {
        setupNavigationBar()
        setupToolbar()
    }
    func setupUX() {
        webView.allowsBackForwardNavigationGestures = true
        
        setupObserver()
    }
    
    func initOpenPage() {
        let url = URL(string: "https://" + initSite.url)!
        webView.load(URLRequest(url: url))
    }
    
    private func setupNavigationBar() {
        let OpenBarButtonItem = UIBarButtonItem(
            title: "Open",
            style: .plain,
            target: self,
            action: #selector(openTapped))
        
        navigationItem.rightBarButtonItem = OpenBarButtonItem
    }
    
    private func setupToolbar() {
        let goBack = UIBarButtonItem(barButtonSystemItem: .undo, target: webView, action: #selector(webView.goBack))
        let goForward = UIBarButtonItem(barButtonSystemItem: .redo, target: webView, action: #selector(webView.goForward))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [goBack, goForward, progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
    }
    
    private func setupObserver() {
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        let url = navigationAction.request.url
        
        if url!.absoluteString.range(of: "about:blank") != nil {
            decisionHandler(.cancel)
            return
        }
        
        if let host = url?.host {
            for website in Site.allCases {
                if host.contains(website.url) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        
        showAlertNotAllowedPage()
        decisionHandler(.cancel)
        
    }
    
    func showAlertNotAllowedPage() {
        let alert = UIAlertController(title: "Block! page load", message: "This page is not allowed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
