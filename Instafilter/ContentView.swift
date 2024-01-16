//
//  ContentView.swift
//  Instafilter
//
//  Created by Leo Chung on 1/15/24.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

/*
 Core Image is Apple's high-performance framework for manipulating images
 Apple has designed dozens of image filters such as blurs, color shifts, pixellations, and more - these are all optimized to take advantage of the GPU on iOS devices
 You can run your Core Image apps in the simulator but it will be quite slow -> the performance is greater on physical devices
 
 Property wrappers wrap our property inside another struct -> this means that when we use @State to wrap a string, the actual type of property we end up with is a State<String>
 
 Open Quickly Command - CMD + SHIFT + O
 Because of the way SwiftUI sends binding updates to property wrappers, property observers used with property wrappers often won't work in the way you expect -> you can fix this by using the onChange() modifier which will tell SwiftUI to run a function of your choosing when a particular value changes
 Note: You can attach onChange() wherever you want in your view hierarchy but it is preferred to put it near the object that is actually changing - in this case, the Slider's value
 The onChange() modifier has two other common variants:
 - One that accepts no parameters at all, for times when you just want to run a function when a value changes but you don't actually care what the new value is
 - One that accepts only the new value, without also passing in the old value; this is DEPRECATED as of iOS 17
 
 confirmationDialog() is an alternative to alert() that lets you add many buttons
 - confirmationDialogs slide up from the button, can contain lots of buttons, and can be dismissed by tapping on Cancel or by tapping outside of the options
 Although they look different, confirmation dialogs and alerts are created almost identically:
 - Both are created by attaching a modifier to our view hierarchy
 - Both get shown automatically by SwiftUI when a condition is true
 - Both can be filled with buttons to take various actions
 - Both can have a second closure attached to provide an extra message
 
 If you want to create images dynamically, SwiftUI's Image view is not up to the job; Instead, Apple gives you three other image types to work with -> you need to use all three if you want to work with Core Image
 - UIImage, which comes from UIKit, is a powerful image type capable of working with a variety of image types, including bitmaps (PNG files), vectors (SVG files), and even sequences that form an animation; UIImage is the standard image type for UIKit And is the closest to SwiftUI's Image type
 - CGImage, which comes from Core Graphics -> this is a simpler image type that is a 2D array of pixels
 - CIImage, which comes from Core Image -> this stores all of the information required to produce an image but doesn't actually turn that into pixels unless asked to do so; Apple calls CIImage an "image recipe" rather than an actual image
 
 We can create a UIImage from a CGImage, and create a CGImage from a UIImage.
 We can create a CIImage from a UIImage and from a CGImage, and can create a CGImage from a CIImage.
 We can create a SwiftUI Image from both a UIImage and a CGImage.
*/

struct ContentView: View {
    @State private var image: Image?
//    @State private var blurAmount = 0.0
//    @State private var showingConfirmation = false
//    @State private var backgroundColor = Color.white
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
        
        // ContentUnavailableView shows a standard user interface for when your app has nothing to display
        ContentUnavailableView("No snippets", systemImage: "swift", description: Text("You don't have any saved snippets yet."))
        
        ContentUnavailableView {
            Label("No snippets", systemImage: "swift")
        } description: {
            Text("You don't have any saved snippets yet.")
        } actions: {
            Button("Create Snippet") {
                // create a snippet
            }
            .buttonStyle(.borderedProminent)
        }
    }

    func loadImage() {
        let inputImage = UIImage(resource: .example)
        let beginImage = CIImage(image: inputImage)

        let context = CIContext()
        
        // Check what inputs the filter supports
        let currentFilter = CIFilter.twirlDistortion()
        currentFilter.inputImage = beginImage

        let amount = 1.0

        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey) }
        
        // Twirl Distortion
//        let currentFilter = CIFilter.twirlDistortion()
//        currentFilter.inputImage = beginImage
//        currentFilter.radius = 1000
//        currentFilter.center = CGPoint(x: inputImage.size.width / 2, y: inputImage.size.height / 2)
        
        // Crystallized
//        let currentFilter = CIFilter.crystallize()
//        currentFilter.inputImage = beginImage
//        currentFilter.radius = 200
        
        // Pixellated Image
//        let currentFilter = CIFilter.pixellate()
//        currentFilter.inputImage = beginImage
//        currentFilter.scale = 100
        
        // Sepia Tone
//        let currentFilter = CIFilter.sepiaTone()
//        currentFilter.inputImage = beginImage
//        currentFilter.intensity = 1
        
        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return }

        // attempt to get a CGImage from our CIImage
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }

        // convert that to a UIImage
        let uiImage = UIImage(cgImage: cgImage)

        // and convert that to a SwiftUI image
        image = Image(uiImage: uiImage)
    }
    
//    var body: some View {
//        Button("Hello, World!") {
//            showingConfirmation = true
//        }
//        .frame(width: 300, height: 300)
//        .background(backgroundColor)
//        .confirmationDialog("Change background", isPresented: $showingConfirmation) {
//            Button("Red") { backgroundColor = .red }
//            Button("Green") { backgroundColor = .green }
//            Button("Blue") { backgroundColor = .blue }
//            Button("Cancel", role: .cancel) { }
//        } message: {
//            Text("Select a new color")
//        }
//        
//        VStack {
//            Text("Hello, World!")
//                .blur(radius: blurAmount)
//
//            Slider(value: $blurAmount, in: 0...20)
//                .onChange(of: blurAmount) { oldValue, newValue in
//                    print("New value is \(newValue)")
//                }
//        }
//    }
}

#Preview {
    ContentView()
}
