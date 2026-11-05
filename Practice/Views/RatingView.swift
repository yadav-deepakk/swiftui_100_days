//
//  RatingView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 05/11/26.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var onColor: Color = .yellow
    var offColor: Color = .gray
    
    var body: some View {
        HStack {
            ForEach(1..<6) { i in
                Button(action: { rating = i }, label: {
                    Image(systemName: "star.fill")
                        .foregroundColor(i<=rating ? onColor:offColor)
                })
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    RatingView(rating: .constant(3))
}
