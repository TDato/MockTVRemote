//
//  ConfigViewController.swift
//  tdatoMockRemoteControl
//
//  Created by Thomas Dato on 3/1/20.
//  Copyright © 2020 Tommy Dato. All rights reserved.
//

import UIKit
var buttonSelection : Int  = 0
var chNum : String? = String()
var chLabel : String? = "Food"

class ConfigViewController: UIViewController {

    @IBOutlet weak var buttonSegment: UISegmentedControl!
    @IBOutlet weak var channelStepper: UIStepper!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var channelInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        channelStepper.minimumValue = 1
        channelStepper.maximumValue = 99
        channelStepper.wraps = true
        channelStepper.value = 1
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        channelInput.text = ""
        channelStepper.value = 1
        channelLabel.text = "1"
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if let chText = channelInput.text {
            if (chText.isEmpty || chText.count > 4) {
                let alert = UIAlertController(title: "Invalid Channel Label", message: "Label must be between 1-4 letters in length", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                present(alert, animated: true)
            } else {

                buttonSelection = buttonSegment.selectedSegmentIndex
                if let chN = channelLabel.text {
                    chNum = chN
                }
                chLabel = chText
                channelInput.text = ""
            }
        }
    }
    
    @IBAction func backgroundTouched(_ sender: UIControl) {
        for tf in textFields {
            tf.resignFirstResponder()
        }
    }
    @IBAction func stepperPressed(_ sender: UIStepper) {
        channelLabel.text = Int(sender.value).description
    }
    
    @IBAction func editEnded(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
}
