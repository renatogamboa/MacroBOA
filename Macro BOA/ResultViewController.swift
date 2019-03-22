//
//  ResultViewController.swift
//  Macro BOA
//
//  Created by Renato Gamboa on 6/16/18.
//  Copyright © 2018 RenatoGamboa. All rights reserved.
//

import UIKit
import Social

class ResultViewController: UIViewController {
    
    var totalCalories: Double?
    var totalCarbs: Double?
    var totalProtein: Double?
    var totalFat: Double?
    
    // Label Outlets
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var carbLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var mealPerDaySegment: UISegmentedControl!
    @IBOutlet weak var CaloriesPerDayLabel: UILabel!
    
    var segmentSwitch = 0
    
    var motto = "Just calculated my macros using the new Macro BOA app! \nCheck it out here:\nhttp://www.boafitness.co/macroboa/"
    
    
    // Control switches
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSegmentDesign()
        
        if let calories = totalCalories {
            calorieLabel?.text = "\(Int(calories))"
        }
        
        if let carbs = totalCarbs {
            carbLabel?.text = "\(Int(carbs)) g"
        }
        
        if let protein = totalProtein {
            proteinLabel?.text = "\(Int(protein)) g"
        }
        
        if let fat = totalFat {
            fatLabel?.text = "\(Int(fat)) g"
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    @IBAction func shareButtonAction(_ sender: Any) {
        // Alert
        let activityController = UIActivityViewController(activityItems: [motto, #imageLiteral(resourceName: "BOAMacroIcon")], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    
    @IBAction func mealsSegmentTapped(_ sender: Any) {
        let getIndex = mealPerDaySegment.selectedSegmentIndex
        print(getIndex)
        
        switch getIndex {
        case 0:
            CaloriesPerDayLabel.text = "CALORIES PER DAY"
            // All meals
            if let calories = totalCalories {
                calorieLabel?.text = "\(Int(calories))"
            }
            
            if let carbs = totalCarbs {
                carbLabel?.text = "\(Int(carbs)) g"
            }
            
            if let protein = totalProtein {
                proteinLabel?.text = "\(Int(protein)) g"
            }
            
            if let fat = totalFat {
                fatLabel?.text = "\(Int(fat)) g"
            }
            break
        case 1:
            CaloriesPerDayLabel.text = "CALORIES PER MEAL"
            // 2 meals
            if let calories = totalCalories {
                calorieLabel?.text = "\(Int(calories / 2))"
            }
            
            if let carbs = totalCarbs {
                carbLabel?.text = "\(Int(carbs / 2)) g"
            }
            
            if let protein = totalProtein {
                proteinLabel?.text = "\(Int(protein / 2)) g"
            }
            
            if let fat = totalFat {
                fatLabel?.text = "\(Int(fat / 2)) g"
            }
            break
        case 2:
            CaloriesPerDayLabel.text = "CALORIES PER MEAL"
            // 3 meals
            if let calories = totalCalories {
                calorieLabel?.text = "\(Int(calories / 3))"
            }
            
            if let carbs = totalCarbs {
                carbLabel?.text = "\(Int(carbs / 3)) g"
            }
            
            if let protein = totalProtein {
                proteinLabel?.text = "\(Int(protein / 3)) g"
            }
            
            if let fat = totalFat {
                fatLabel?.text = "\(Int(fat / 3)) g"
            }
            break
        case 3:
            CaloriesPerDayLabel.text = "CALORIES PER MEAL"
            // 4 meals
            if let calories = totalCalories {
                calorieLabel?.text = "\(Int(calories / 4))"
            }
            
            if let carbs = totalCarbs {
                carbLabel?.text = "\(Int(carbs / 4)) g"
            }
            
            if let protein = totalProtein {
                proteinLabel?.text = "\(Int(protein / 4)) g"
            }
            
            if let fat = totalFat {
                fatLabel?.text = "\(Int(fat / 4)) g"
            }
            break
        case 4:
            CaloriesPerDayLabel.text = "CALORIES PER MEAL"
            // 5 meals
            if let calories = totalCalories {
                calorieLabel?.text = "\(Int(calories / 5))"
            }
            
            if let carbs = totalCarbs {
                carbLabel?.text = "\(Int(carbs / 5)) g"
            }
            
            if let protein = totalProtein {
                proteinLabel?.text = "\(Int(protein / 5)) g"
            }
            
            if let fat = totalFat {
                fatLabel?.text = "\(Int(fat / 5)) g"
            }
            break
        default:
            CaloriesPerDayLabel.text = "CALORIES PER DAY"
            // All meals
            if let calories = totalCalories {
                calorieLabel?.text = "\(Int(calories))"
            }
            
            if let carbs = totalCarbs {
                carbLabel?.text = "\(Int(carbs)) g"
            }
            
            if let protein = totalProtein {
                proteinLabel?.text = "\(Int(protein)) g"
            }
            
            if let fat = totalFat {
                fatLabel?.text = "\(Int(fat)) g"
            }
            break
        }
    }
    
    func setUpSegmentDesign(){
        mealPerDaySegment.layer.cornerRadius = 12.0
        mealPerDaySegment.layer.borderWidth = 1
        mealPerDaySegment.layer.borderColor = UIColor.white.cgColor
        mealPerDaySegment.layer.masksToBounds = true
    }

}
