//
//  ContentView.swift
//  WebViewVideoPlayer
//
//  Created by bartvk on 20/01/2020.
//  Copyright © 2020 DutchVirtual. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var urlString = ""
    @State var statusString = ""
    
    var body: some View {
        VStack(spacing: 20) {
            WebView(urlString: self.$urlString, statusString: self.$statusString)
            
            Button("Load") {
//                self.urlString = "assets-library://asset/2uneKmW?ext=mp4"
                self.urlString = "https://www.example.com"
            }
            Spacer()
            Text("Status: " + self.statusString)
            .lineLimit(1)
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
