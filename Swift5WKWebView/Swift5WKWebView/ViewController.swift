//
//  ViewController.swift
//  Swift5WKWebView
//
//  Created by AkiyukiIshikawa on 2020/05/02.
//  Copyright © 2020 AkiyukiIshikawa. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    var webView = WKWebView()
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        webView.frame = CGRect(
            x: 0,
            y: toolBar.frame.size.height,
            width: view.frame.size.width,
            height: view.frame.size.height - 2*toolBar.frame.size.height
        )
        
        view.addSubview(webView)
        
        webView.navigationDelegate = self
        
        let url = URL(string: "https://www.yahoo.co.jp/")
        let request = URLRequest(url: url!)

        webView.load(request)
        
        
       
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("読み込み開始")
        indicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("読み込み完了")
        indicator.stopAnimating()
    }

    @IBAction func go(_ sender: Any) {
        webView.goForward()
    }
    
    
    @IBAction func back(_ sender: Any) {
        webView.goBack()
    }
}

