//
//  ProfileViewController.swift
//  PlatePal
//
//  Created by user233480 on 4/1/23.
//

import UIKit

import PhotosUI

import ParseSwift



class ProfileViewController: UIViewController{
    @IBOutlet weak var UserPhoto: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userNameLabel: UILabel!
    private var meals = [Post]() {
        didSet {
            // Reload table view data any time the posts variable gets updated.
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false

        
        UserPhoto.layer.cornerRadius = UserPhoto.frame.height / 2
        
        userNameLabel.text = "USERNAME"
        
        
        
        //meals = Meal.mockMeals
        //print(meals)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        queryPosts()
    }
    
    private func queryPosts(completion: (() -> Void)? = nil) {
        // TODO: Pt 1 - Query Posts
        // https://github.com/parse-community/Parse-Swift/blob/3d4bb13acd7496a49b259e541928ad493219d363/ParseSwift.playground/Pages/2%20-%20Finding%20Objects.xcplaygroundpage/Contents.swift#L66

        // 1. Create a query to fetch Posts
        // 2. Any properties that are Parse objects are stored by reference in Parse DB and as such need to explicitly use `include_:)` to be included in query results.
        // 3. Sort the posts by descending order based on the created at date
        // 4. TODO: Pt 2 - Only include results created yesterday onwards
        // 5. TODO: Pt 2 - Limit max number of returned posts

        // Get the date for yesterday. Adding (-1) day is equivalent to subtracting a day.
        // NOTE: `Date()` is the date and time of "right now".
        let query = Post.query()
            .include("user")
            .order([.descending("createdAt")]) // <- Only include results created yesterday onwards
            .limit(20) // <- Limit max number of returned posts to 10

        // Find and return posts that meet query criteria (async)
        query.find { [weak self] result in
            switch result {
            case .success(let meals):
                // Update the local posts property with fetched posts
                self?.meals = meals
            case .failure(let error):
                self?.showAlert(description: error.localizedDescription)
            }

            // Call the completion handler (regardless of error or success, this will signal the query finished)
            // This is used to tell the pull-to-refresh control to stop refresshing
            completion?()
        }
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
    
    

    

}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        meals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as? MealCell else {
            return UITableViewCell()
        }
        cell.configure(with: meals[indexPath.row])
        //cell.layer.cornerRadius = 15
        //cell.layer.masksToBounds = true
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate { }
