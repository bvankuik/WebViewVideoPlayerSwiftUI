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
    enum Status {
        case idle
        case loading(status: String)
        case error(message: String)
    }
    
    @Binding var urlString: String
    @Binding var status: Status
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        switch self.status {
        case .idle:
            if let url = URL(string: self.urlString) {
                uiView.load(URLRequest(url: url))
            }
        default:
            break
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
          self.parent.status = .loading(status: "Starting")
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            self.parent.status = .loading(status: "Loading")
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            self.parent.status = .error(message: error.localizedDescription)
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            self.parent.status = .error(message: error.localizedDescription)
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.parent.status = .idle
        }
        
        init(_ parent: WebView) {
            self.parent = parent
        }
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(urlString: .constant(""), status: .constant(.idle))
            .background(Color.gray)
            .previewDevice("iPhone 8")
    }
}
