//
//  PostViewController.swift
//  lab-insta-parse
//
//  Created by Charlie Hieger on 11/1/22.
//

import UIKit

// TODO: Pt 1 - Import Photos UI
import PhotosUI

// TODO: Pt 1 - Import Parse Swift
import ParseSwift

class PostViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var foodText: UITextView!
    @IBOutlet weak var captionText: UITextField!
    @IBOutlet weak var previewImageView: UIImageView!

    private var pickedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onChooseImageTapped(_ sender: Any) {
        // TODO: Pt 1 - Present Image picker
        // Create and configure PHPickerViewController

        // Create a configuration object
        var config = PHPickerConfiguration()

        // Set the filter to only show images as options (i.e. no videos, etc.).
        config.filter = .images

        // Request the original file format. Fastest method as it avoids transcoding.
        config.preferredAssetRepresentationMode = .current

        // Only allow 1 image to be selected at a time.
        config.selectionLimit = 1

        // Instantiate a picker, passing in the configuration.
        let picker = PHPickerViewController(configuration: config)

        // Set the picker delegate so we can receive whatever image the user picks.
        picker.delegate = self

        // Present the picker
        present(picker, animated: true)
    }
    
    func fetchData(_ completion: @escaping (_ success: Bool, _ data: Data?) -> Void) {
        
        let encodedFood = (foodText.text).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "NA"
        let encodedUrl = "https://api.edamam.com/api/food-database/v2/parser?app_id=6a10ccf0&app_key=0ec3ac0c506b764c99b57c8473335240&ingr=" + encodedFood
        print("ENCODED URL: " + encodedUrl)
        let url = URL(string: encodedUrl)!

        // Use the URL to instantiate a request
        let request = URLRequest(url: url)

        // Create a URLSession using a shared instance and call its dataTask method
        // The data task method attempts to retrieve the contents of a URL based on the specified URL.
        // When finished, it calls it's completion handler (closure) passing in optional values for data (the data we want to fetch), response (info about the response like status code) and error (if the request was unsuccessful)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in

            // Handle any errors
            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
            }


            // The `JSONSerialization.jsonObject(with: data)` method is a "throwing" function (meaning it can throw an error) so we wrap it in a `do` `catch`
            // We cast the resultant returned object to a dictionary with a `String` key, `Any` value pair.
            if let data = data {
                completion(true, data)
            } else {
                completion(false, nil)
            }
        }
        

        // Initiate the network request
        task.resume()
    }
    


    @IBAction func onShareTapped(_ sender: Any) {
        // Dismiss Keyboard
        view.endEditing(true)

        // TODO: Pt 1 - Create and save Post

        // Unwrap optional pickedImage
        guard let image = pickedImage,
              // Create and compress image data (jpeg) from UIImage
              let imageData = image.jpegData(compressionQuality: 0.1) else {
            return
        }

        // Create a Parse File by providing a name and passing in the image data
        let imageFile = ParseFile(name: "image.jpg", data: imageData)

        // Create Post object
        var post = Post()

        // Set properties
        post.imageFile = imageFile
        post.caption = captionText.text
        post.food = foodText.text
        
        
        fetchData { success, data in
            do{
                if success {
                    let res = try JSONDecoder().decode(PostResponse.self, from: data!)
                    var totalCal: Float = 0.0
                    var totalProtein: Float = 0.0
                    var totalFat: Float = 0.0
                    var totalCarbs: Float = 0.0
                    for food in res.parsed {
                        totalCal += food.food.nutrients.ENERC_KCAL
                        totalProtein += food.food.nutrients.PROCNT
                        totalFat += food.food.nutrients.FAT
                        totalCarbs += food.food.nutrients.CHOCDF
                    }
                    post.mealCal = totalCal
                    post.mealPro = totalProtein
                    post.mealFat = totalFat
                    post.mealCar = totalCarbs
                    //print("\n\n\nCaption: \(post.caption)\nFood: \(post.food)\nCalories: \(post.mealCal)\nProtein: \(post.mealPro)\nFat: \(post.mealFat)\nCarbs:  \(post.mealCar)\n\n\n")
                    // Set the user as the current user
                    post.user = User.current
                    
                    // Save post (async)
                    post.save { [weak self] result in
                        
                        // Switch to the main thread for any UI updates
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let post):
                                print("✅ Post Saved! \(post)")
                                
                                // Get the current user
                                if var currentUser = User.current {
                                    
                                    // Update the `lastPostedDate` property on the user with the current date.
                                    
                                    // Save updates to the user (async)
                                    currentUser.save { [weak self] result in
                                        switch result {
                                        case .success(let user):
                                            print("✅ User Saved! \(user)")
                                            
                                            // Switch to the main thread for any UI updates
                                            DispatchQueue.main.async {
                                                // Return to previous view controller
                                                self?.navigationController?.popViewController(animated: true)
                                            }
                                            
                                        case .failure(let error):
                                            self?.showAlert(description: error.localizedDescription)
                                        }
                                    }
                                }
                                
                                
                            case .failure(let error):
                                self?.showAlert(description: error.localizedDescription)
                            }
                        }
                    }
                } else {
                    // Show an error message
                    print("Network request failed")
                }
            } catch {
                print("error")
            }
        }

        
    }

    @IBAction func onTakePhotoTapped(_ sender: Any) {
        // Make sure the user's camera is available
        // NOTE: Camera only available on physical iOS device, not available on simulator.
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("❌📷 Camera not available")
            return
        }

        // Instantiate the image picker
        let imagePicker = UIImagePickerController()

        // Shows the camera (vs the photo library)
        imagePicker.sourceType = .camera

        // Allows user to edit image within image picker flow (i.e. crop, etc.)
        // If you don't want to allow editing, you can leave out this line as the default value of `allowsEditing` is false
        imagePicker.allowsEditing = true

        // The image picker (camera in this case) will return captured photos via it's delegate method to it's assigned delegate.
        // Delegate assignee must conform and implement both `UIImagePickerControllerDelegate` and `UINavigationControllerDelegate`
        imagePicker.delegate = self

        // Present the image picker (camera)
        present(imagePicker, animated: true)


    }

    @IBAction func onViewTapped(_ sender: Any) {
        // Dismiss keyboard
        view.endEditing(true)
    }
}

// TODO: Pt 1 - Add PHPickerViewController delegate and handle picked image.
extension PostViewController: PHPickerViewControllerDelegate {

    // PHPickerViewController required delegate method.
    // Returns PHPicker result containing picked image data.
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

        // Dismiss the picker
        picker.dismiss(animated: true)

        // Make sure we have a non-nil item provider
        guard let provider = results.first?.itemProvider,
              // Make sure the provider can load a UIImage
              provider.canLoadObject(ofClass: UIImage.self) else { return }

        // Load a UIImage from the provider
        provider.loadObject(ofClass: UIImage.self) { [weak self] object, error in

            // Make sure we can cast the returned object to a UIImage
            guard let image = object as? UIImage else {
                self?.showAlert()
                return
            }

            // Check for and handle any errors
            if let error = error {
                self?.showAlert(description: error.localizedDescription)
                return
            } else {

                // UI updates (like setting image on image view) should be done on main thread
                DispatchQueue.main.async {

                    // Set image on preview image view
                    self?.previewImageView.image = image

                    // Set image to use when saving post
                    self?.pickedImage = image
                }
            }
        }
    }
}

extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Delegate method that's called when user finishes picking image (photo library or camera)
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Dismiss the image picker
            picker.dismiss(animated: true)

            // Get the edited image from the info dictionary (if `allowsEditing = true` for image picker config).
            // Alternatively, to get the original image, use the `.originalImage` InfoKey instead.
            guard let image = info[.editedImage] as? UIImage else {
                print("❌📷 Unable to get image")
                return
            }

            // Set image on preview image view
            previewImageView.image = image

            // Set image to use when saving post
            pickedImage = image
    }
}
