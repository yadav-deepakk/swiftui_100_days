//
//  Student.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 05/11/26.
//

import Foundation
import SwiftData

@Model
class Student {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
