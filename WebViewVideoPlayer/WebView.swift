//
//  WebView.swift
//  WebViewVideoPlayer
//
//  Created by bartvk on 20/01/2020.
//  Copyright © 2020 DutchVirtual. All rights reserved.
//

import SwiftUI
import WebKit

extension URL {
    static var blank: URL {
        URL(string: "about:blank")!
    }
}

struct WebView: UIViewRepresentable {
    @Binding var status: String
    @Binding var url: URL
}

// UIViewRepresentable
extension WebView {
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: url))
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

extension WebView {
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            self.parent.status = "Starting"
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            self.parent.status = "Loading..."
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.parent.status = "Finished"
        }
        
        init(_ parent: WebView) {
            self.parent = parent
        }
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(status: .constant(""), url: .constant(URL.blank))
            .frame(width: 300, height: 200)
            .background(Color.gray)
            .previewDevice("iPhone 8")
    }
}
