//
//  webContentDisplayView.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 26.01.24.
//

import Foundation

import SwiftUI

import WebKit

struct webContentDisplayView: UIViewRepresentable {
    
    let webContent: String
    
    // creates and returns and instance of the view
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        //connects a web view's navigation events to a SwiftUI coordinator, managing communication between SwiftUI and the underlying web component.
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    //updates content when parameter changes
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: "\(webContent)") else {return}
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: webContentDisplayView
        
        init(parent: webContentDisplayView) {
            self.parent = parent
            }
        }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}
