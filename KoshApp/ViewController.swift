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
    var secondsRemaining = 10

    @IBOutlet weak var timerLabel: UILabel!
    
    @IBAction func startPressed(_ sender: UIButton) {
        secondsRemaining = 10
        print("START pressed")
        playSound(fileName: "C")
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
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
            timerLabel.text = "\(secondsRemaining)"
            secondsRemaining -= 1
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

