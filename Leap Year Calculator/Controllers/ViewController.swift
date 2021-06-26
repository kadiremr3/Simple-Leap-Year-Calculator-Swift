//
//  ViewController.swift
//  Leap Year Calculator
//
//  Created by Kadir Emre on 9.03.2021.
//

//required functions
//when we press the random button a random leap year will be saved to the realm also that year's condition will be evaluated.
//when we press the history button we will go to the tableview controller also show the previous leapyears that are saved

import UIKit
import RealmSwift
import CLTypingLabel

class ViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Outlets and Objects
    
    @IBOutlet weak var statusView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var enterAYear: UILabel!
    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    
    @IBOutlet var buttons: [UIButton]!
   
    let realm = try! Realm()
    var leapYear = LeapYear()
    
    //MARK: - LifeCycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        textField.delegate = self
        textField.keyboardType = .numberPad
        
        navigationController?.isNavigationBarHidden = true

        for button in buttons{
            
            button.layer.cornerRadius = 8
            
            if button == submitButton{
                button.titleLabel?.font = UIFont(name: "Pacifico-Regular", size: 25)
            }else{
                button.titleLabel?.font = UIFont(name: "Pacifico-Regular", size: 17)
            }
        }
        buildHourglassAnimation()
    }
    
    //MARK: - Button Pressed Methods
 
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
        textField.placeholder = ""
        
        if textField.text == "" {
            self.createAlert(titleField: "Error", messageField: "Please make sure you entered a year before tapping the submit button")
        }else {
            let submitButtonText = LeapYear()
            submitButtonText.year = Int(textField.text!)!
            self.statusView.startAnimating()
            leapYear.calculateYear(year: submitButtonText.year, imageView: statusView)
            textField.text = ""
            save(leapYearToAdd: submitButtonText)
        }
    }
    
    @IBAction func randomButtonPressed(_ sender: UIButton) {
        
        enterAYear.text = ""
        textField.placeholder = ""
        
        self.statusView.startAnimating()
        
        let myRandomYear = LeapYear()
        myRandomYear.year = myRandomYear.randomYear()
        myRandomYear.calculateYear(year: myRandomYear.year, imageView: statusView)
 
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.textField.placeholder = "Random year is \(myRandomYear.year)"
        }
        
        save(leapYearToAdd: myRandomYear)
    }
    
    
    
    @IBAction func historyButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToHistoryVC", sender: self)
    }
    
    //MARK: - TextField Delegate Methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        enterAYear.text = ""
        textField.placeholder = ""
    }
    
    // MARK: - Data Manipulation Methods

    func save(leapYearToAdd: LeapYear) {
        realm.beginWrite()
        realm.add(leapYearToAdd)
        try! realm.commitWrite()
    }
    
    //MARK: - Animation of the Status View
    
    func buildHourglassAnimation(){
        let imageNames = ["hourglass1","hourglass2","hourglass3","hourglass4","hourglass5","hourglass6"]
        
        var images = [UIImage]()
        
        for i in 0...5{
            images.append(UIImage(named: imageNames[i])!)
        }
        statusView.animationImages = images
        statusView.animationDuration = 2
        statusView.animationRepeatCount = 1
    }
    
    //MARK: - Alert Creation and Segue Methods
    
    func createAlert(titleField: String, messageField: String) {
        let alertMessage = UIAlertController(title: titleField, message: messageField, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alertMessage.addAction((okButton))
        self.present(alertMessage, animated: true, completion: nil)
    }
}
