//
//  Web.swift
//  Yummy
//
//  Created by Ahmed on 30/08/2023.
//

import SwiftUI
import WebKit
 
struct WebView: UIViewRepresentable {
    var url: URL
 
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
