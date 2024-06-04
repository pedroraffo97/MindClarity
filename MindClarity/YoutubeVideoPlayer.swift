//
//  YoutubeVideoPlayer.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 19.01.24.
//

import Foundation

import SwiftUI

import WebKit



struct YoutubeVideoPlayer: UIViewRepresentable {

        let videoID: String
        
        func makeUIView(context: Context) -> WKWebView {
            //used to display web content in your app.
            let webView = WKWebView()
            //connects a web view's navigation events to a SwiftUI coordinator, managing communication between SwiftUI and the underlying web component.
            webView.navigationDelegate = context.coordinator
            return webView
            }
        
        func updateUIView(_ uiView: WKWebView, context: Context) {
            guard let url = URL(string: "\(videoID)") else { return }
            let request = URLRequest(url: url)
            uiView.load(request)
            }
            
        func makeCoordinator() -> Coordinator {
            Coordinator(parent: self)
            }
    
        class Coordinator: NSObject, WKNavigationDelegate {
        var parent: YoutubeVideoPlayer
        
        init(parent: YoutubeVideoPlayer) {
            self.parent = parent
                }
        }
}
