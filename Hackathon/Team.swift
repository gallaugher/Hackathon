//
//  Team.swift
//  Hackathon
//
//  Created by John Gallaugher on 8/11/18.
//  Copyright © 2018 John Gallaugher. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase

class Team {
    var teamName: String
    var university: String
    var coordinate: CLLocationCoordinate2D
    var projectName: String
    var description: String
    var postingUserID: String
    var createdOn: Date
    var documentID: String
    
    var dictionary: [String: Any] {
        return ["teamName": teamName, "university": university, "longitude": longitude, "latitude": latitude, "projectName": projectName, "description": description, "postingUserID": postingUserID, "createdOn": createdOn]
    }
    
    var latitude: CLLocationDegrees {
        return coordinate.latitude
    }
    
    var longitude: CLLocationDegrees {
        return coordinate.longitude
    }

    init(teamName: String, university: String, coordinate: CLLocationCoordinate2D, projectName: String, description: String, postingUserID: String, createdOn: Date, documentID: String){
        self.teamName = teamName
        self.university = university
        self.coordinate = coordinate
        self.projectName = projectName
        self.description = description
        self.postingUserID = postingUserID
        self.createdOn = Date()
        self.documentID = documentID
    }
    
    convenience init() {
        self.init(teamName: "", university: "", coordinate: CLLocationCoordinate2D(), projectName: "", description: "", postingUserID: "", createdOn: Date(), documentID: "")
    }
    
    convenience init(dictionary: [String: Any]) {
        let teamName = dictionary["teamName"] as! String? ?? ""
        let university = dictionary["university"] as! String? ?? ""
        let latitude = dictionary["latitude"] as! CLLocationDegrees? ?? 0.0
        let longitude = dictionary["longitude"] as! CLLocationDegrees? ?? 0.0
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let projectName = dictionary["projectName"] as! String? ?? ""
        let description = dictionary["description"] as! String? ?? ""
        let postingUserID = dictionary["postingUserID"] as! String? ?? ""
        let createdOn = dictionary["createdOn"] as! Date? ?? Date()
        self.init(teamName: teamName, university: university, coordinate: coordinate, projectName: projectName, description: description, postingUserID: postingUserID, createdOn: createdOn, documentID: "")
    }
    
    func saveData(completion: @escaping (Bool) -> ())  {
        let db = Firestore.firestore()
        // Grab the user ID
        guard let postingUserID = (Auth.auth().currentUser?.uid) else {
            print("*** ERROR: Could not save data because we don't have a valid postingUserID")
            return completion(false)
        }
        self.postingUserID = postingUserID
        // Create the dictionary representing data we want to save
        let dataToSave: [String: Any] = self.dictionary
        print("*** DATA TO SAVE IS :\(dataToSave)")
        // if we HAVE saved a record, we'll have an ID
        if self.documentID != "" {
            let ref = db.collection("teams").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                if let error = error {
                    print("ERROR: updating document \(error.localizedDescription)")
                    completion(false)
                } else { // It worked!
                    completion(true)
                }
            }
        } else { // Otherwise create a new document via .addDocument
            var ref: DocumentReference? = nil // Firestore will create a new ID for us
            ref = db.collection("teams").addDocument(data: dataToSave) { (error) in
                if let error = error {
                    print("ERROR: adding document \(error.localizedDescription)")
                    completion(false)
                } else { // It worked! Save the documentID in Spot’s documentID property
                    self.documentID = ref!.documentID
                    completion(true)
                }
            }
        }
    }
}
