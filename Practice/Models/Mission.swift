//
//  Missions.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 25/10/26.
//

import Foundation

struct Mission: Codable, Identifiable {
    
    struct CrewRole: Codable {
        var name: String
        var role: String
    }
    
    var id: Int
    var crew: [CrewRole]
    var launchDate: Date?
    var description: String
    
    var displayName: String { "Apollo \(self.id)" }
    var image: String { "apollo\(self.id)" }
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "NA"
    }
    
}
