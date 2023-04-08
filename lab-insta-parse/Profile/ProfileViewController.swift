//
//  ProfileViewController.swift
//  PlatePal
//
//  Created by user233480 on 4/1/23.
//

import UIKit

import PhotosUI

import ParseSwift



class ProfileViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var UserPhoto: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userNameLabel: UILabel!
    var meals: [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        UserPhoto.layer.cornerRadius = UserPhoto.frame.height / 2
        
        userNameLabel.text = "USERNAME"
        
        let query = PFQuery(className:"Post")
        query.whereKey("user", equalTo:"AFl9EBRXzU")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
            } else if let objects = objects {
                // The find succeeded.
                print("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                for object in objects {
                    print(object.objectId as Any)
                }
            }
        }
        
        meals = Meal.mockMeals
        print(meals)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapPhoto(_ sender: UITapGestureRecognizer) {
        
        if let tappedView = sender.view {
            performSegue(withIdentifier: "UpdatePhotoSegue", sender: tappedView)
        }
        print("did tap image view", sender)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a cell with identifier, "TrackCell"
        // the `dequeueReusableCell(withIdentifier:)` method just returns a generic UITableViewCell so it's necessary to cast it to our specific custom cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as! MealCell

        // Get the track that corresponds to the table view row
        let meal = meals[indexPath.row]

        // Configure the cell with it's associated track
        cell.configure(with: meal)

        // return the cell for display in the table view
        return cell
    }

    

}
