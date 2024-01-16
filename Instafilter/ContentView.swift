//
//  ContentView.swift
//  Instafilter
//
//  Created by Leo Chung on 1/15/24.
//

import SwiftUI

/*
 Core Image is Apple's high-performance framework for manipulating images
 Apple has designed dozens of image filters such as blurs, color shifts, pixellations, and more - these are all optimized to take advantage of the GPU on iOS devices
 You can run your Core Image apps in the simulator but it will be quite slow -> the performance is greater on physical devices
*/

struct ContentView: View {
    @State private var blurAmount = 0.0 {
        didSet {
            print("New value is \(blurAmount)")
        }
    }

    var body: some View {
        VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)

            Slider(value: $blurAmount, in: 0...20)

            Button("Random Blur") {
                blurAmount = Double.random(in: 0...20)
            }
        }
    }
}

#Preview {
    ContentView()
}
