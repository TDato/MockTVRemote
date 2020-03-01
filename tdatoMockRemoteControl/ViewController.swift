//
//  ViewController.swift
//  tdatoMockRemoteControl
//
//  Created by Thomas Dato on 2/5/20.
//  Copyright © 2020 Tommy Dato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var BottomView: UIView!
    
    var channelDisplayText : String! = "7"
    var firstNumPressed = false
    var secondNumpressed = false
    @IBOutlet weak var powerStatusLabel: UILabel!
    @IBOutlet weak var currentVolumeLabel: UILabel!
    @IBOutlet weak var currentChannelLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var powerSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        enableAllControls(false)
    }

    @IBAction func segementToggled(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        case 0:
            channelDisplayText = "72"
        case 1:
            channelDisplayText = "15"
        case 2:
            channelDisplayText = "56"
        case 3:
            channelDisplayText = "62"
        default:
            break
        }
        
        currentChannelLabel.text = channelDisplayText
    }
    @IBAction func powerSwitchToggled(_ sender: UISwitch) {
        powerStatusLabel.text = sender.isOn ? "On" : "Off"
        powerSwitch.setOn(sender.isOn, animated: true)
        enableAllControls(powerSwitch.isOn)
    }
    @IBAction func volumeSliderMoved(_ sender: UISlider) {
        currentVolumeLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        if (firstNumPressed == true)
        {
              if let s = sender.currentTitle {
                if (channelDisplayText != "0") {
                     //concatenate the strings
                    channelDisplayText += s
                }
                 else {
                     // only print the second number
                    channelDisplayText = s
                }
                
                if (channelDisplayText != "00" && channelDisplayText != "0") {
                    currentChannelLabel.text = channelDisplayText
                }
                
            }
         
            firstNumPressed = false
        }
        else {
            if let s = sender.currentTitle {
                channelDisplayText = s
                firstNumPressed = true
            }
        }
      
        

    }
    @IBAction func channelDownPressed(_ sender: UIButton) {
        if (channelDisplayText == "1")
        {
            channelDisplayText = "99"
        }
        else
        {
            if let i = Int(channelDisplayText) {
                channelDisplayText = "\((i) - 1 )"
            }
            
        }
        
         currentChannelLabel.text = channelDisplayText
    }
    @IBAction func channelUpPressed(_ sender: UIButton) {
        if (channelDisplayText == "99")
        {
            channelDisplayText = "1"
        }
        else
        {
            if let i = Int(channelDisplayText) {
                channelDisplayText = "\((i) + 1 )"
            }
            
        }
        
         currentChannelLabel.text = channelDisplayText
    }
    
    func enableAllControls(_ status : Bool) {
        BottomView.isUserInteractionEnabled = status

    }
}

