//
//  TeamViewController.swift
//  Hackathon
//
//  Created by John Gallaugher on 8/11/18.
//  Copyright © 2018 John Gallaugher. All rights reserved.
//

import UIKit
import GooglePlaces

class TeamViewController: UIViewController {
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var teamNameField: UITextField!
    @IBOutlet weak var universityField: UITextField!
    @IBOutlet weak var projectNameField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var team: Team!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if team == nil {
            team = Team()
        }
        updateUserInterfaace()
    }
    
    func updateUserInterfaace() {
        teamNameField.text = team.teanName
        universityField.text = team.university
        projectNameField.text = team.projectName
        descriptionTextView.text = team.description
    }

    @IBAction func findLocationPressed(_ sender: UIBarButtonItem) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}

extension TeamViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        team.coordinate = place.coordinate
        descriptionTextView.text = "Latitude: \(team.coordinate.latitude)\nLongitude: \(team.coordinate.latitude)"
        universityField.text = place.name
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
