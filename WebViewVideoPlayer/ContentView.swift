//
//  ContentView.swift
//  WebViewVideoPlayer
//
//  Created by bartvk on 20/01/2020.
//  Copyright © 2020 DutchVirtual. All rights reserved.
//

import SwiftUI

struct StatusText: View {
    @Binding var status: WebView.Status
    var statusString: String {
        switch self.status {
        default:
            return ""
        }
    }
    
    var body: some View {
        Text(self.statusString)
        .lineLimit(1)

    }
}

struct ContentView: View {
    @State var urlString = ""
    @State var status: WebView.Status = .idle
    
    var body: some View {
        VStack(spacing: 20) {
            WebView(urlString: self.$urlString, status: self.$status)
            
            Button("Load") {
                self.urlString = "https://sample-videos.com/video123/mp4/240/big_buck_bunny_240p_1mb.mp4"
            }
            Spacer()
            StatusText(status: self.$status)
        }
        .padding()
        .background(Color.gray)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
