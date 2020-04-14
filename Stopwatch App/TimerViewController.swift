//
//  ViewController.swift
//  Stopwatch App
//
//  Created by AshutoshD on 13/04/20.
//  Copyright © 2020 ravindraB. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet weak var stopView: UIView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    
    var seconds: Double = 0
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        stopView.layer.cornerRadius  = stopView.bounds.width / 2
        stopView.clipsToBounds = true
        
        stopView.layer.borderWidth = 10
        stopView.layer.borderColor = UIColor.cyan.cgColor
        
        btnPause.layer.cornerRadius  = 5
        btnPause.clipsToBounds = true
    
        btnReset.layer.cornerRadius  = 5
        btnReset.clipsToBounds = true
        
        btnStart.layer.cornerRadius  = 5
        btnStart.clipsToBounds = true
        
        
    }

    @IBAction func StartBtnTapped(_ sender: UIButton) {
        if isTimerRunning == false {
            btnStart.isEnabled = false
            runTimer()
        }
    }
    
    @IBAction func PauseBtnTapped(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
            self.btnPause.setTitle("Resume",for: .normal)
            btnReset.isEnabled = true
        } else {
            btnReset.isEnabled = false
            runTimer()
            self.resumeTapped = false
            self.btnPause.setTitle("Pause",for: .normal)
        }
    }
    
    @IBAction func ResetBtnTapped(_ sender: UIButton) {
        self.btnPause.setTitle("Pause",for: .normal)
        self.resumeTapped = false
        btnStart.isEnabled = true
        lblTime.text = "00:00:00"
        timer.invalidate()  
       seconds = 0    //Here we manually enter the restarting point for the seconds, but it would be wiser to make this a variable or constant.
   //     lblTime.text = "\(seconds)"
        isTimerRunning = false
        
    }
    
    
    func runTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(TimerViewController.updateTimer)), userInfo: nil, repeats: true)
        
        
    }
    @objc func updateTimer() {
//        if seconds < 1 {
//            timer.invalidate()
//        }else{
            seconds += 1     //This will decrement(count down)the seconds.
            lblTime.text = timeString(time: TimeInterval(seconds)) //This will update the label.
//        }

    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}

