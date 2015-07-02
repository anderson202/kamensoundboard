//
//  ViewController.swift
//  kamensoundboard
//
//  Created by Anderson Ng on 2015-06-30.
//  Copyright (c) 2015 Anderson Ng. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    var audioPlayer = AVAudioPlayer()
    var finalRidePressed = false
    var finalForm = [String]()
    var kamenRide = false
    var currentRider = ""

    
    
    @IBAction func playKamenRide(sender: UIButton) {
        var soundToPlay: String
        if finalForm.count >= 9{
            finalForm.removeAtIndex(0)
        }
        currentRider = sender.currentTitle!
        finalForm.append(sender.currentTitle!)
        if sender.currentTitle! == "KamenRide"{
            kamenRide = true
        }

        if finalRidePressed && sender.currentTitle != "FinalRide" && sender.currentTitle != "KamenRide"{
            soundToPlay = sender.currentTitle! + "2"
            finalRidePressed = false
        }else{
            soundToPlay = sender.currentTitle!
        }
        var currentSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(soundToPlay, ofType: "wav")!)
        audioPlayer = AVAudioPlayer(contentsOfURL: currentSound, error: nil)
        audioPlayer.delegate = self
        audioPlayer.play()

    }
    
    @IBAction func playAttackRide(sender: UIButton) {
        
    }
    
    @IBAction func playFinalRide() {
        finalRidePressed = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blackColor()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        var decadeForm = ["Kuuga", "Agito", "Ryuki", "Faiz", "Blade", "Hibiki", "Kabuto", "Deno", "Kiva"]
        
        if finalForm.last == "KamenRide" || finalForm.last == "FinalRide"{
            var currentSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("standingby", ofType: "wav")!)
            audioPlayer = AVAudioPlayer(contentsOfURL: currentSound, error: nil)
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        }else if finalForm == decadeForm {
            var currentSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("FinalRide", ofType: "wav")!)
            audioPlayer = AVAudioPlayer(contentsOfURL: currentSound, error: nil)
            audioPlayer.play()
        }else if kamenRide{
            var currentSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("change"+currentRider, ofType: "wav")!)
            audioPlayer = AVAudioPlayer(contentsOfURL: currentSound, error: nil)
            audioPlayer.play()
            kamenRide = false
        }
        
    }
}

