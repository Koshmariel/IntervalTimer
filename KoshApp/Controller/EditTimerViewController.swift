//
//  EditTimerViewController.swift
//  KoshApp
//
//  Created by Aleksey on 12.11.2021.
//

import UIKit

let maxDuration = 60


class EditTimerViewController: UIViewController {
    
    var duration: Int?
    //duration2 = duration!

    override func viewDidLoad() {
        super.viewDidLoad()
        durationSlider.minimumValue = 0
        durationSlider.maximumValue = Float(maxDuration)
        durationSlider.value = Float(duration!)
        
        durationLabel.text = String(duration!) + "s"
        // set your startValue here
        // Do any additional setup after loading the view.
        }
    

    
    
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var durationSlider: UISlider!
    
    @IBAction func durationSliderChanged(_ sender: UISlider) {
        duration = Int(sender.value)
        print(duration!)
        durationLabel.text = String(duration!) + "s"
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
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
