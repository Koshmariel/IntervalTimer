//
//  ViewController.swift
//  KoshApp
//
//  Created by Aleksey on 28.09.2021.
//

import UIKit
import AVFoundation //play sounds

class ViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
    
    var player: AVAudioPlayer!
    var timer = Timer()
    var totalTime = 10.0
    var secondsRemaining = 10.0
    var secondsPassed = 0.0
    let timerStep = 0.1

    @IBOutlet weak var timerLabel: UILabel!
    
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func startPressed(_ sender: UIButton) {
        secondsRemaining = totalTime
        secondsPassed = 0.0
        print("START pressed")
        playSound(fileName: "C")
        timer.invalidate()
        progressBar.progress = 0.0
        
        timer = Timer.scheduledTimer(timeInterval: timerStep, target: self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
    }
    
    func playSound(fileName: String) {
        let url = Bundle.main.url(forResource: fileName, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        print("\(fileName) played")
    }
    
    @objc func updateTimer() {
        if secondsRemaining >= 0 {
            print("\(secondsRemaining) seconds remaining.")
            timerLabel.text = "\(Int(secondsRemaining.rounded()))"
            print("\(Int(secondsRemaining.rounded())) in label.")
            secondsRemaining -= timerStep
            secondsPassed += timerStep
            let percentageProgress = secondsPassed / totalTime
            progressBar.progress = Float(percentageProgress)
            print("\(Float(percentageProgress)) in progress bar")
        } else {
            timer.invalidate()
            timerLabel.text = "DONE"
            playSound(fileName: "E")
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

