//
//  AstronautView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 26/10/26.
//

import SwiftUI

struct AstronautView: View {
    var astronaut: Astronaut
    var body: some View {
        ScrollView {
            Image(astronaut.id)
                .resizable()
                .scaledToFit()
            VStack {
                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let astronauts: [String : Astronaut] = Bundle.main.decode("astronauts.json")
    AstronautView(astronaut: astronauts["stafford"]!)
        .preferredColorScheme(.dark)
}
