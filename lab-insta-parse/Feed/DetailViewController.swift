//
//  DetailViewController.swift
//  PlatePal
//
//  Created by user229735 on 4/9/23.
//

import UIKit
import Alamofire
import AlamofireImage

class DetailViewController: UIViewController {
    
    var post: Post!
    private var imageDataRequest: DataRequest?
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = post.user {
            usernameLabel.text = user.username
        }
        
        if let imageFile = post.imageFile,
           let imageUrl = imageFile.url {

            // Use AlamofireImage helper to fetch remote image from URL
            imageDataRequest = AF.request(imageUrl).responseImage { [weak self] response in
                switch response.result {
                case .success(let image):
                    // Set image view image with fetched image
                    self?.imageView.image = image
                case .failure(let error):
                    print("❌ Error fetching image: \(error.localizedDescription)")
                    break
                }
            }
        }

        // Caption
        captionLabel.text = post.caption
        foodLabel.text = post.food
        caloriesLabel.text = "Calories: " +  String(format: "%.0f", ceil(post.mealCal!)) + "cal"
        caloriesLabel.font = UIFont(name: "Charter", size: 20)
        proteinLabel.text = "Protein: " +  String(format: "%.0f", ceil(post.mealPro!)) + "g"
        fatLabel.text = "Fat: " +  String(format: "%.0f", ceil(post.mealFat!)) + "g"
        carbsLabel.text = "Carbs: " +  String(format: "%.0f", ceil(post.mealCar!)) + "g"
        foodLabel.font = UIFont(name: "Charter", size: 20)
        proteinLabel.font = UIFont(name: "Charter", size: 20)
        fatLabel.font = UIFont(name: "Charter", size: 20)
        carbsLabel.font = UIFont(name: "Charter", size: 20)
        // Do any additional setup after loading the view.
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
