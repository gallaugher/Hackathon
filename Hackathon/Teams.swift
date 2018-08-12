//
//  Teams.swift
//  Hackathon
//
//  Created by John Gallaugher on 8/12/18.
//  Copyright © 2018 John Gallaugher. All rights reserved.
//

import Foundation
import Firebase

class Teams {
    var teamArray: [Team] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ())  {
        db.collection("teams").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("*** ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.teamArray = []
            // there are querySnapshot!.documents.count documents in teh spots snapshot
            for document in querySnapshot!.documents {
                let team = Team(dictionary: document.data())
                team.documentID = document.documentID
                self.teamArray.append(team)
            }
            completed()
        }
    }
}
