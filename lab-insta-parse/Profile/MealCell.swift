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
    func configure(with meal: Meal) {
        mealNameLabel.text = meal.mealName
        mealCalLabel.text = meal.mealCal
        mealProLabel.text = meal.mealPro
        mealCarLabel.text = meal.mealCar
        mealFatLabel.text = meal.mealFat
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
