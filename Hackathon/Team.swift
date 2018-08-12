//
//  Team.swift
//  Hackathon
//
//  Created by John Gallaugher on 8/11/18.
//  Copyright © 2018 John Gallaugher. All rights reserved.
//

import Foundation
import CoreLocation

class Team {
    var teanName: String
    var university: String
    var coordinate: CLLocationCoordinate2D
    var projectName: String
    var description: String
    var createdBy: String
    var createdOn: Date
    var teamMembers: [String]

    init(teamName: String, university: String, coordinate: CLLocationCoordinate2D, projectName: String, description: String, createdBy: String, createdOn: Date, teamMembers: [String]){
        self.teanName = teamName
        self.university = university
        self.coordinate = coordinate
        self.projectName = projectName
        self.description = description
        self.createdBy = createdBy
        self.createdOn = Date()
        self.teamMembers = teamMembers
    }
    
    convenience init() {
        self.init(teamName: "", university: "", coordinate: CLLocationCoordinate2D(), projectName: "", description: "", createdBy: "", createdOn: Date(), teamMembers: [])
    }
}
