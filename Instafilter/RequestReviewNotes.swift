//
//  RequestReviewNotes.swift
//  Instafilter
//
//  Created by Leo Chung on 1/16/24.
//

import SwiftUI
import StoreKit

/*
 There is a special environment key called .requestReview which lets you ask the user to leave a review of the app on the App Store -> Apple will take care of showing the entire user interface so we just need to take care of making the request when ready
 
 It's better to requestReview automatically when you think it's the right time - a good starting place is when the user has performed an important task some number of times because that way it's clear that they have realized the benefit of your application
*/

struct RequestReviewNotes: View {
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        Button("Leave a review") {
            requestReview()
        }
    }
}

#Preview {
    RequestReviewNotes()
}
