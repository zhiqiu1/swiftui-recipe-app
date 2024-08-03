//
//  YouTubeView.swift
//  Recipe
//
//  Created by Zhi Qiu on 8/2/24.
//

import Foundation
import SwiftUI
import WebKit

struct YouTubeView: UIViewRepresentable {
    let videoID: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoID)") else {
            return
        }
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
