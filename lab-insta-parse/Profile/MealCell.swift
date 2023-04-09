//
//  MealCell.swift
//  PlatePal
//
//  Created by user233480 on 4/1/23.
//

import UIKit

class MealCell: UITableViewCell {

    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealCalLabel: UILabel!
    @IBOutlet weak var mealProLabel: UILabel!
    @IBOutlet weak var mealCarLabel: UILabel!
    @IBOutlet weak var mealFatLabel: UILabel!
    
    /// Configures the cell's UI for the given track.
    func configure(with post: Post) {
        mealNameLabel.text = post.caption
        
        mealCalLabel.text = "\(ceil(post.mealCal!))"
        mealProLabel.text = "\(ceil(post.mealPro!))"
        mealCarLabel.text = "\(ceil(post.mealCar!))"
        mealFatLabel.text = "\(ceil(post.mealFat!))"
        // Load image async via Nuke library image loading helper method
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
