//
//  VideoPlayerView.swift
//  SweetTreatsGuide
//
//  Created by Dev on 19/02/2024.
//

import SwiftUI
import WebKit

struct YouTubeView: UIViewRepresentable {
    let videoId: String
    func makeUIView(context: Context) ->  WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let demoURL = URL(string: videoId) else {
            return
        }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: demoURL))
    }
}
