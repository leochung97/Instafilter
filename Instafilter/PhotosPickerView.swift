//
//  PhotosPickerView.swift
//  Instafilter
//
//  Created by Leo Chung on 1/16/24.
//

import SwiftUI
import PhotosUI

/*
 PhotosPicker view provides you a simple way to import one or more photos from the user's photo library
 To avoid causing any performance hiccups, the data gets provided as a special type called PhotosPickerItem, which you can load asynchronously to convert the data into a SwiftUI Image
*/

struct PhotosPickerView: View {
    @State private var pickerItem: PhotosPickerItem?
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImage: Image?
    @State private var selectedImages = [Image]()
    
    var body: some View {
        VStack {
            selectedImage?
                .resizable()
                .scaledToFit()
            
            ScrollView {
                ForEach(0..<selectedImages.count, id: \.self) { i in
                    selectedImages[i]
                        .resizable()
                        .scaledToFit()
                }
            }
            
            // PhotosPicker("Select a picture", selection: $pickerItem, matching: .images)
            PhotosPicker(selection: $pickerItems, maxSelectionCount: 3, matching: .any(of: [.images, .not(.screenshots)])) {
                Label("Select a picture", systemImage: "photo")
            }

        }
        .onChange(of: pickerItem) {
            Task {
                selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
            }
        }
        .onChange(of: pickerItems) {
            Task {
                selectedImages.removeAll()

                for item in pickerItems {
                    if let loadedImage = try await item.loadTransferable(type: Image.self) {
                        selectedImages.append(loadedImage)
                    }
                }
            }
        }
    }
}

#Preview {
    PhotosPickerView()
}
