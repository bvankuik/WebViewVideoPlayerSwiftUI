//
//  WebView.swift
//  WebViewVideoPlayer
//
//  Created by bartvk on 20/01/2020.
//  Copyright © 2020 DutchVirtual. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @Binding var urlString: String
    @Binding var statusString: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard !urlString.isEmpty else {
            return
        }
        
        if let url = URL(string: self.urlString) {
            uiView.load(URLRequest(url: url))
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

extension WebView {
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//            self.parent.statusString = "Starting"
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
//            self.parent.statusString = "Loading..."
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            self.parent.statusString = error.localizedDescription
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            self.parent.statusString = error.localizedDescription
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.parent.statusString = "Finished loading"
        }
        
        init(_ parent: WebView) {
            self.parent = parent
        }
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(urlString: .constant(""), statusString: .constant(""))
            .background(Color.gray)
            .previewDevice("iPhone 8")
    }
}
