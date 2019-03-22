//
//  MacroViewController.swift
//  Macro BOA
//
//  Created by Renato Gamboa on 6/11/18.
//  Copyright © 2018 RenatoGamboa. All rights reserved.
//

import UIKit

class MacroViewController: UIViewController, UITextFieldDelegate {
    
    // Fields
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var heightFieldcm: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var heightFieldft: UITextField!
    @IBOutlet weak var heightFieldin: UITextField!
    
    
    // Segmented Controls
    @IBOutlet weak var weightSegment: UISegmentedControl!
    @IBOutlet weak var heightSegment: UISegmentedControl!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var activitySegment: UISegmentedControl!
    @IBOutlet weak var goalSegment: UISegmentedControl!
    
    
    // Variables for segmented controls
    var weight: Double?
    var height: Double?
    var feet: Double?
    var inches: Double?
    var age: Double?
    var gender: Double?
    var activity: Double?
    var goal: Double?
    
    // Var segmented controls
    var kg = false
    var cm = false
    var female = false
    var activitySwitch = 0
    var goalSwitch = 0
    
    // This will be passed on to views
    var macroCal: Double?
    var macroProtein: Double?
    var macroCarb: Double?
    var macroFat: Double?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up segment design
        setUpSegmentDesign()
        
        // weight
        weightField.delegate = self
        
        // height
        heightFieldcm.delegate = self
        heightFieldft.delegate = self
        heightFieldin.delegate = self
        
        // age
        ageField.delegate = self
        
        // Done Buttons
        weightField.addDoneButtonToKeyboard(myAction:  #selector(self.weightField.resignFirstResponder))
        heightFieldcm.addDoneButtonToKeyboard(myAction:  #selector(self.heightFieldcm.resignFirstResponder))
        heightFieldft.addDoneButtonToKeyboard(myAction:  #selector(self.heightFieldft.resignFirstResponder))
        heightFieldin.addDoneButtonToKeyboard(myAction:  #selector(self.heightFieldin.resignFirstResponder))
        ageField.addDoneButtonToKeyboard(myAction:  #selector(self.ageField.resignFirstResponder))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func enterTapped(_ sender: Any) {
        validate()
        performSegue(withIdentifier: "macroSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let destination = segue.destination as? ResultViewController {
            destination.totalCalories = macroCal
            destination.totalProtein = macroProtein
            destination.totalFat = macroFat
            destination.totalCarbs = macroCarb
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ageField.resignFirstResponder()
    }
    
    func validate(){
        let alert = UIAlertController()
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        // Weight Validation
        if weightField.text! == "" {
            alert.message = "Please Enter Weight"
            self.present(alert, animated: true, completion: nil)
        }
            
            // Double(weightField.text) <= 0 {
        
        // Height Validation
            // Cm Field Empty
        else if cm == true && heightFieldcm.text == "" {
            alert.message = "Please Enter Height"
            self.present(alert, animated: true, completion: nil)
        } else if cm == true && Double(heightFieldcm.text!)! <= 0.0 {
            alert.message = "Please Enter Valid Height"
            self.present(alert, animated: true, completion: nil)
        }
        
            // Ft Field Empty
        else if cm == false && (heightFieldft.text == "" || heightFieldin.text == ""){
            alert.message = "Please Enter Height"
            self.present(alert, animated: true, completion: nil)
        }
            // Invalid Age
        else if cm == false && (Double(heightFieldft.text!)! <= 0.0 || Double(heightFieldft.text!)! >= 10.0 || Double(heightFieldin.text!)! < 0.0 || Double(heightFieldin.text!)! > 12.0) {
            alert.message = "Please Enter Valid Height"
            self.present(alert, animated: true, completion: nil)
        }
            //Age Field Empty
        else if ageField.text == "" {
            alert.message = "Please Enter Age"
            self.present(alert, animated: true, completion: nil)
        }
            
        else if Double(ageField.text!)! <= 0 || Double(ageField.text!)! > 110 {
            alert.message = "Please Enter Valid Age"
            self.present(alert, animated: true, completion: nil)
        }
        
        // Everything is valid, calculate
        else {
            print(calculateMacros())
        }
        
    }
    
    // Calculate BMR
    func calculate() -> Double{
        
        // Get text from fields
        weight = Double(weightField.text!)
        
        if cm == true {
            height = Double(heightFieldcm.text!)
        } else if cm == false {
            feet = Double(heightFieldft.text!)
            inches = Double(heightFieldin.text!)
        }
        age = Double(ageField.text!)
        
        // If statements for segmented controls
        if kg == false {
            weight = (weight! / 2.2046226218) // conversion to kg from lg
        }
        if cm == false {
            height = (feet! * 30.48) + (inches! * 2.54)
        }
        
        if female == true {
            gender = -161
        } else {
            gender = 5
        }
        
        if activitySwitch == 0 {
            activity = 1.3
        } else if activitySwitch == 1 {
            activity = 1.55
        } else if activitySwitch == 2 {
            activity = 1.65
        } else if activitySwitch == 3 {
            activity = 1.80
        } else if activitySwitch == 4 {
            activity = 2.0
        }
        
        if goalSwitch == 0 {
            goal = 0.8
        } else if goalSwitch == 1 {
            goal = 1.0
        } else if goalSwitch == 2 {
            goal = 1.1
        }
        
        
        let v1 = 10 * weight! // weight
        let v2 = 6.25 * height! // height
        let v3 = 5 * age! // age
        let v4 = gender! // gender
        let v5 = activity! // activity level
        let v6 = goal! // goal
        
        // result
        
        // TDEE = BMR * Activity Level Multiplier
        var result = v5 * (v1 + v2 - v3 + v4)
        
        result *= v6

        
        return result
    }
    
    func calculateMacros() {
        // Total Calories
        let result = calculate()
        
        macroCal = result
        
        macroProtein = (weight! * 2.2046226218)
        
        macroFat = 0.3 * (weight! * 2.2046226218)
        
        macroCarb = result - ((macroProtein! * 4.0) + (macroFat! * 9.0)
        )
        
        // Get macro grams
        macroCarb = macroCarb! / 4
        
    }
    
    // Text Field Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        let textTag = textField.tag+1
        let nextResponder = textField.superview?.viewWithTag(textTag) as UIResponder?
        if(nextResponder != nil)
        {
            //textField.resignFirstResponder()
            nextResponder?.becomeFirstResponder()
        }
        else{
            // stop editing on pressing the done button on the last text field.
            
            self.view.endEditing(true)
        }
        return true
    }
    
    
    // Segment control switchs
    @IBAction func weightSegmentTapped(_ sender: Any) {
        
        let getIndex = weightSegment.selectedSegmentIndex
        print(getIndex)
        
        switch getIndex {
        case 0:
            kg = false
            break
        case 1:
            kg = true
            break
        default:
            kg = false
            break
        }
    }
    
    @IBAction func heightSegmentTapped(_ sender: Any) {
        
        let getIndex = heightSegment.selectedSegmentIndex
        print(getIndex)
        
        switch getIndex {
        case 0:
            cm = false
            
            // Switch visibility of view controllers
            heightFieldcm.isHidden = true
            heightFieldft.isHidden = false
            heightFieldin.isHidden = false
            break
        case 1:
            cm = true
            
            heightFieldcm.isHidden = false
            heightFieldft.isHidden = true
            heightFieldin.isHidden = true
            break
        default:
            cm = false
            
            heightFieldcm.isHidden = true
            heightFieldft.isHidden = false
            heightFieldin.isHidden = false
            break
        }
    }
    @IBAction func genderSegmentTapped(_ sender: Any) {
        let getIndex = genderSegment.selectedSegmentIndex
        print(getIndex)
        
        switch getIndex {
        case 0:
            female = false
            break
        case 1:
            female = true
            break
        default:
            female = false
            break
        }
    }
    
    @IBAction func activitySegmentTapped(_ sender: Any) {
        
        let getIndex = activitySegment.selectedSegmentIndex
        print(getIndex)
        
        switch getIndex {
        case 0:
            activitySwitch = 0
            break
        case 1:
            activitySwitch = 1
            break
        case 2:
            activitySwitch = 2
            break
        case 3:
            activitySwitch = 3
            break
        case 4:
            activitySwitch = 4
            break
        default:
            activitySwitch = 0
            break
        }
    }
    
    @IBAction func goalSegmentTapped(_ sender: Any) {
        
        let getIndex = goalSegment.selectedSegmentIndex
        print(getIndex)
        
        switch getIndex {
        case 0:
            goalSwitch = 0
            break
        case 1:
            goalSwitch = 1
            break
        case 2:
            goalSwitch = 2
            break
        default:
            goalSwitch = 0
            break
        }
    }
    
    
    func setUpSegmentDesign(){
        weightSegment.layer.cornerRadius = 20.0
        weightSegment.layer.borderWidth = 1
        weightSegment.layer.borderColor = UIColor.white.cgColor
        weightSegment.layer.masksToBounds = true
        
        heightSegment.layer.cornerRadius = 20.0
        heightSegment.layer.borderWidth = 1
        heightSegment.layer.borderColor = UIColor.white.cgColor
        heightSegment.layer.masksToBounds = true
        
        genderSegment.layer.cornerRadius = 20.0
        genderSegment.layer.borderWidth = 1
        genderSegment.layer.borderColor = UIColor.white.cgColor
        genderSegment.layer.masksToBounds = true
        
        // Fix activity segment font layout
        activitySegment.apportionsSegmentWidthsByContent = true
        let font = UIFont.systemFont(ofSize: 12)
        activitySegment.setTitleTextAttributes([NSAttributedStringKey.font: font],for: .normal)
    }
    
    // Light Content Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension UITextField{
    
    func addDoneButtonToKeyboard(myAction:Selector?){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        doneToolbar.barStyle = UIBarStyle.blackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: myAction)
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
}
