//
//  ShareLinkNotes.swift
//  Instafilter
//
//  Created by Leo Chung on 1/16/24.
//

import SwiftUI

/*
 ShareLink view lets users export content from our app to share elsewhere, such as saving a picture to their photo library, sending a link to a friend using Messages, and more
*/

struct ShareLinkNotes: View {
    var body: some View {
        let example = Image(.example)

        ShareLink(item: example, preview: SharePreview("Singapore Airport", image: example)) {
            Label("Click to share", systemImage: "airplane")
        }

    }
}

#Preview {
    ShareLinkNotes()
}
