//
//  ViewController.swift
//  KoshApp
//
//  Created by Aleksey on 28.09.2021.
//

import UIKit
import AVFoundation //play sounds

class TimerViewController: UIViewController {
    
    var myTimer = TimerModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerName.text = myTimer.timerName
        timerLabel.text = String(Int(myTimer.totalTime))
        progressBar.progress = 0.0
        print("timerLabel.accessibilityIdentifier = \(timerLabel.accessibilityIdentifier)")
        print("timerLabel.accessibilityLabel = \(timerLabel.accessibilityLabel)")
    }
    
    var player: AVAudioPlayer!

    var timer = Timer()
//    var totalTime = 6.0
//    var secondsRemaining = 10.0
//    var secondsPassed = 0.0
//    let timerStep = 0.1

    @IBOutlet weak var timerName: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func startPressed(_ sender: UIButton) {
        myTimer.secondsRemaining = myTimer.totalTime
        myTimer.secondsPassed = 0.0
        print("START pressed")
        print("totalTime = \(myTimer.totalTime)")
        playSound(fileName: "C")
        timer.invalidate()
        progressBar.progress = 0.0
        
        timer = Timer.scheduledTimer(timeInterval: myTimer.timerStep, target: self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
    }
    
    @IBAction func editTimerButtonPresed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToEditTimer", sender: self)
        
//        let editTimer = EditTimerViewController()
//        editTimer.completion = { [weak self] duration in
//            DispatchQueue.main.async {
//                self?.totalTime = Double(duration!)
//                print("editTimer completed, totalTime now is \(self?.totalTime)")
//            }
//        }
    }
    
    func playSound(fileName: String) {
        let url = Bundle.main.url(forResource: fileName, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        print("\(fileName) played")
    }
    
    @objc func updateTimer() {
        if myTimer.secondsRemaining >= 0 {
            print("\(myTimer.secondsRemaining) seconds remaining.")
            timerLabel.text = "\(Int(myTimer.secondsRemaining.rounded()))"
            print("\(Int(myTimer.secondsRemaining.rounded())) in label.")
            myTimer.secondsRemaining -= myTimer.timerStep
            myTimer.secondsPassed += myTimer.timerStep
            let percentageProgress = myTimer.secondsPassed / myTimer.totalTime
            progressBar.progress = Float(percentageProgress)
            print("\(Float(percentageProgress)) in progress bar")
        } else {
            timer.invalidate()
            timerLabel.text = "DONE"
            playSound(fileName: "E")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEditTimer" {
            let destinationVC = segue.destination as! EditTimerViewController
            destinationVC.duration = Int(myTimer.totalTime)
            destinationVC.timerName = myTimer.timerName
            print("Passing duration = \(myTimer.totalTime) to Edit screen")
            
            destinationVC.completion = { [weak self] timerData in //if I check timerData it is described as Declaration let timerData: Int? Declared In TimerViewController.swift
                        DispatchQueue.main.async {
                            self?.myTimer.totalTime = Double(timerData.duration!) //ERROR  Argument passed to call that takes no arguments + ERROR Value of type 'Int?' has no member 'duration'
                            //self?.myTimer.timerName = String(timerName)
                            self?.timerLabel.text = String(timerData.duration!)  //ERROR  Argument passed to call that takes no arguments + ERROR Value of type 'Int?' has no member 'duration'
                            self?.myTimer.timerName = timerData.name
                            self?.timerName.text = timerData.name
                            print("editTimer completed, totalTime now is \(self?.myTimer.totalTime)")
                            self?.timer.invalidate()
                        }
            }
        }
    }
    
    /*
    //Complex function
    var player: AVAudioPlayer?
    func playSound() {
                    guard let url = Bundle.main.url(forResource: "C", withExtension: "wav") else {return}
                                //project resources              name              extension
                    do {
                        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                        //                                              .ambient for usage with sound off
                        try AVAudioSession.sharedInstance().setActive(true)
                        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
                        guard let player = player else {return}
                        player.play()
                        } catch let error { print(error.localizedDescription) }
        
    }
    */
    
    
}

