//
//  MissionDetailView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 26/10/26.
//

import SwiftUI

struct CrewRole {
    var role: String
    var astronaut: Astronaut
}

struct MissionDetailView: View {
    var mission: Mission
    var astronauts: [String: Astronaut]
    var crewList: [CrewRole]
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.astronauts = astronauts
        self.mission = mission
        self.crewList = mission.crew.map { member in
            if let astronuat = astronauts[member.name] {
                return CrewRole(role: member.role, astronaut: astronuat)
            } else {
                fatalError("Crew member doesn't exists in astronuats.json file")
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFill()
                    .containerRelativeFrame(.horizontal) { width, axes in
                        width * 0.6
                    }
                if mission.formattedLaunchDate != "NA" {
                    Text(mission.formattedLaunchDate)
                        .font(.headline.bold())
                        .foregroundStyle(.secondary)
                        .padding(.top, 5)
                }
                
                DividerView()
                
                VStack(alignment: .leading) {
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom)
                    Text(mission.description)
                    
                    DividerView()
                    
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
            }
            .padding(.horizontal)
            
            HorizontalCrewListScrollView(crewList: self.crewList)
            
        }
        .navigationTitle("Apollo \(mission.id)")
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}


struct DividerView: View {
    var height = 2
    var body: some View {
        Rectangle()
            .frame(height: CGFloat(self.height))
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

struct HorizontalCrewListScrollView: View {
    var crewList: [CrewRole]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crewList, id:\.self.role) { member in
                    NavigationLink {
                        AstronautView(astronaut: member.astronaut)
                    } label: {
                        HStack {
                            Image(member.astronaut.id)
                                .resizable()
                                .clipShape(.capsule)
                                .frame(width: 104, height: 72)
                                .overlay {
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                }
                            VStack(alignment: .leading) {
                                Text(member.astronaut.name)
                                    .font(.headline.bold())
                                    .foregroundStyle(.white)
                                Text(member.role)
                                    .font(.headline.bold())
                                    .foregroundStyle(.gray)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.bottom)
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    MissionDetailView(mission: missions[3], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
