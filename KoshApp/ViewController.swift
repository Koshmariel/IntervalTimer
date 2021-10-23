//
//  ViewController.swift
//  KoshApp
//
//  Created by Aleksey on 28.09.2021.
//

import UIKit
import AVFoundation //play sounds

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }


    @IBAction func startPressed(_ sender: UIButton) {
        print("START pressed")
        playSound(fileName: "C")
    }
    
    func playSound(fileName: String) {
        let url = Bundle.main.url(forResource: fileName, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        print("\(fileName) played")
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

