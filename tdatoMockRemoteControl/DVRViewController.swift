//
//  DVRViewController.swift
//  tdatoMockRemoteControl
//
//  Created by Thomas Dato on 2/23/20.
//  Copyright © 2020 Tommy Dato. All rights reserved.
//

import UIKit

class DVRViewController: UIViewController {

    enum DvrStates : String
    {
        case Playing = "Playing"
        case Stopped = "Stopped"
        case Paused = "Paused"
        case FForward = "Fast forwarding"
        case FRewind = "Fast rewinding"
        case Recording = "Recording"
    }
    @IBOutlet weak var DVRPowerStatusLabel: UILabel!
    @IBOutlet weak var DVRCurrStateLabel: UILabel!
    @IBOutlet weak var ButtonView: UIView!
    @IBOutlet weak var powerSwitch: UISwitch!
    
    let dvrStates : [String] = ["Playing", "Stopped", "Paused", "Fast forwarding", "Fast rewinding", "Recording"]
    override func viewDidLoad() {
        super.viewDidLoad()
        enableAllControls(powerSwitch.isOn)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func powerSwitchToggled(_ sender: UISwitch) {
        if (!powerSwitch.isOn) {
            DVRCurrStateLabel.text = dvrStates[1];
        }
        DVRPowerStatusLabel.text = sender.isOn ? "On" : "Off"
        powerSwitch.setOn(sender.isOn, animated: true)
    
        enableAllControls(powerSwitch.isOn)
    }
    
    func enableAllControls(_ status : Bool) {
        
        ButtonView.isUserInteractionEnabled = status
    }
    
    @IBAction func dvrButtonPressed(_ sender: UIButton) {
        
        
        if let labelText = DVRCurrStateLabel.text {
            let buttonPressed = dvrStates[sender.tag - 1]
            if (sender.tag == 3 || sender.tag == 4 || sender.tag == 5) {
                // if the button pressed was pause, ffoward or frewind
                // check if it is currently in play state
                if (labelText == dvrStates[0]) {
                    DVRCurrStateLabel.text = buttonPressed
                } else {
                    displayActionSheet(buttonPressed: buttonPressed, labelText: labelText)
                }
            }
            else if (sender.tag == 6){
                // recording only allowed when in the stopped state
                if (labelText == dvrStates[1]) {
                    DVRCurrStateLabel.text = buttonPressed
                } else {
                    displayActionSheet(buttonPressed: buttonPressed, labelText: labelText)
                }
                 
            }
            else {
                DVRCurrStateLabel.text = buttonPressed
            }

        }


    }
    
    func displayActionSheet(buttonPressed : String, labelText: String) {
        let optionMenu = UIAlertController(title: nil, message: "Force the operation?", preferredStyle: .actionSheet)
                           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                           let forceAction = UIAlertAction(title: "Continue", style: .default, handler: {
                               action in
                               // stop current operation
                              
                               let alertMessage = UIAlertController(title: "Forced Operation",  message: "Current operation: \(labelText) has been stopped. Forcing \(buttonPressed)", preferredStyle: .alert)
                                self.DVRCurrStateLabel.text = self.dvrStates[1]
                               alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                               self.DVRCurrStateLabel.text = buttonPressed
                               self.present(alertMessage, animated: true, completion: nil)
                               
                           })
                           
                           optionMenu.addAction(cancelAction)
                           optionMenu.addAction(forceAction)
                           self.present(optionMenu, animated: true, completion: nil)
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
