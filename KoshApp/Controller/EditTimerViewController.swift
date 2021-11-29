//
//  EditTimerViewController.swift
//  KoshApp
//
//  Created by Aleksey on 12.11.2021.
//

import UIKit


class EditTimerViewController: UIViewController, UITextFieldDelegate {
                                               
    let maxDuration = 60
    var duration: Int? //timer duraton is passed from Timer
    var timerName: String?
    
    public var completion: ((Int?) -> Void)?
    
    
 
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var durationSlider: UISlider!
    @IBOutlet weak var timerNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //timerNameField.placeholder = timerName
        timerNameField.text = timerName
        durationSlider.minimumValue = 0
        durationSlider.maximumValue = Float(maxDuration)
        durationSlider.value = Float(duration!)
        durationLabel.text = String(duration!) + "s"
        
        timerNameField.delegate = self                                                 //Hide Keyboard In Swift On Pressing Return Key
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))   //Dismiss Keyboard When Clicking On Background
        view.addGestureRecognizer(tap) // Add gesture recognizer to background view    //Dismiss Keyboard When Clicking On Background
        }
    
    @objc func handleTap() {                                                           //Dismiss Keyboard When Clicking On Background
        timerNameField.resignFirstResponder() // dismiss keyoard
        }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {                     //Hide Keyboard In Swift On Pressing Return Key
        //timerNameField.endEditing(true)
        textField.endEditing(true)
        print("timerName is set to \(timerNameField.text), closing keyboard")
        return true
    }


    /*
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        timerNameField.endEditing(true)
        print("timerName is set to \(timerNameField.text), closing keyboard")
        return true
    }
 */
    
    @IBAction func durationSliderChanged(_ sender: UISlider) {
        duration = Int(sender.value)
        print(duration!)
        durationLabel.text = String(duration!) + "s"
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        print("Cancel pressed, dismissing Edit screen")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        print("Save pressed, duration is \(duration!)")
        timerName = timerNameField.text
        print("timerName is set to \(timerNameField.text)")
        completion?(duration!)
        self.dismiss(animated: true, completion: nil)

    }
}
