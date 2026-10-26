//
//  HomeView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 25/10/26.
//

import SwiftUI

struct HomeView: View {
    @State private var isGridLayout:Bool = true
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationStack {
            VStack {
                if isGridLayout {
                    MissionsGridView(missions: missions, astronauts: astronauts)
                } else {
                    MissionsListView(missions: missions, astronauts: astronauts)
                }
            }
            .toolbar{
                ToolbarItem {
                    Button(action: {isGridLayout.toggle()}, label: {
                        Image(systemName: !isGridLayout ? "square.grid.2x2":"list.dash")
                    })
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

struct MissionsGridView: View {
    var missions: [Mission]
    var astronauts: [String: Astronaut]
    let layout = [
        GridItem(.adaptive(minimum: 150))
    ]
    var body : some View {
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionDetailView(mission: mission, astronauts: astronauts)
                    } label: {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding(.vertical, 10)
                            
                            VStack {
                                Text("\(mission.displayName)")
                                    .font(.headline.bold())
                                    .foregroundStyle(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .cornerRadius(12)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.lightBackground, lineWidth: 1)
                        }
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct MissionsListView: View {
    var missions: [Mission]
    var astronauts: [String: Astronaut]
    var body: some View {
        Form {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionDetailView(mission: mission, astronauts: astronauts)
                } label: {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.title3.bold())
                        Text(mission.formattedLaunchDate)
                            .font(.caption.bold())
                            .foregroundStyle(.gray)
                    }
                    .padding(.leading, 8)
                }
            }
            .listRowBackground(Color.clear)
        }
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    HomeView()
}
