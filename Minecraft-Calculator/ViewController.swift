//
//  ViewController.swift
//  Minecraft-Calculator
//
//  Created by kenneth moody on 2/12/16.
//  Copyright © 2016 iMoody Studios. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftvalStr = ""
    var rightvalStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        
        let soundUrl = URL(fileURLWithPath: path!)
        
        do {
            
           try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            
            btnSound.prepareToPlay()
      
        } catch  let err as NSError {
            
            print(err.debugDescription)
        }
    }

    @IBAction func numberPressed(_ btn: UIButton!) {
        
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }

    @IBAction func resetbtn(_ btn: UIButton!) {
        playSound()
        runningNumber = ""
        leftvalStr = ""
        rightvalStr = ""
        currentOperation = Operation.Empty
        result = ""
        outputLbl.text = "0"
    }
    @IBAction func onDividePressed(_ sender: AnyObject) {
        proccessOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(_ sender: AnyObject) {
        proccessOperation(Operation.Multiply)
    }
    
    @IBAction func onAddPressed(_ sender: AnyObject) {
        proccessOperation(Operation.Add)
    }
    
    @IBAction func onSubtractPressed(_ sender: AnyObject) {
        proccessOperation(Operation.Subtract)
    }
    
    @IBAction func onEqualPressed(_ sender: AnyObject) {
        proccessOperation(currentOperation)
    }
    
    func proccessOperation(_ op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            // Run some math
           
            // A user selected an operator, but then selected another operator without first entering a number
            if runningNumber != "" {
                rightvalStr = runningNumber
                runningNumber = ""
               
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftvalStr)! * Double(rightvalStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftvalStr)! / Double(rightvalStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftvalStr)! - Double(rightvalStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftvalStr)! + Double(rightvalStr)!)"
                }

                
                leftvalStr = result
                outputLbl.text = result
            }
        
           
            
            currentOperation = op
            
        } else {
            // This is the first time the an operator has been pressed
            leftvalStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    
func playSound() {
    if btnSound.isPlaying {
        btnSound.stop()
    }
    btnSound.play()
 }

}
