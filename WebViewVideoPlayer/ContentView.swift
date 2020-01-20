//
//  ContentView.swift
//  WebViewVideoPlayer
//
//  Created by bartvk on 20/01/2020.
//  Copyright © 2020 DutchVirtual. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var status = ""
    @State var url = URL.blank

    var body: some View {
        HStack {
            WebView(status: self.$status, url: self.$url)
                .background(Color.gray)
            
            Button("Load") {
                self.url = URL(string: "assets-library://asset/2uneKmW?ext=mp4")!
            }
            Spacer()
            Text(self.status)
                .frame(width: .infinity)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
