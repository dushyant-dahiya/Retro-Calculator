//
//  ViewController.swift
//  retro-calculator
//
//  Created by Dushyant Dahiya on 1/11/16.
//  Copyright © 2016 DUSHYANT DAHIYA. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

   
    enum Operations: String {
        case Multiply = "*"
        case Divide = "/"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    var currentOperation : Operations = Operations.Empty
    
    @IBOutlet weak var counterLbl : UILabel!
    
    
    
    var btnSound : AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do{
        try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    

    
    @IBAction func numberPressed(sender:UIButton){
        playSound()
        runningNumber += String(sender.tag)
        counterLbl.text = runningNumber
    }
    
    
    
    @IBAction func addOperatorPressed(sender:UIButton){
        performOperation(Operations.Add)
    }
    
    @IBAction func subtractOperatorPressed(sender:UIButton){
        performOperation(Operations.Subtract)
    }
    
    
    @IBAction func multiplyOperatorPressed(sender:UIButton){
        performOperation(Operations.Multiply)
    }
    
    @IBAction func divisionOperatorPressed(sender:UIButton){
        performOperation(Operations.Divide)
    }
    
    @IBAction func equalToOperatorPressed(sender:UIButton){
        performOperation(currentOperation)
    }
    
    func performOperation(op: Operations){
        btnSound.play()
        if currentOperation != Operations.Empty {
            if runningNumber != ""
            {
                rightValStr = runningNumber
                runningNumber = ""
                if currentOperation == Operations.Add{
                    result = String(Double(leftValStr)! + Double(rightValStr)!)
                    //counterLbl.text = String (result)
                }else if currentOperation == Operations.Divide {
                    result = String(Double(leftValStr)! / Double(rightValStr)!)
                }else if currentOperation == Operations.Multiply {
                    result = String(Double(leftValStr)! * Double(rightValStr)!)
                }else if currentOperation == Operations.Subtract {
                    result = String(Double(leftValStr)! - Double(rightValStr)!)
                }
                
                leftValStr = result
                counterLbl.text = result
                
            }
            
            currentOperation = op
            
        }else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
            
        }
    }
    
    @IBAction func clearBtnPressed(sender: UIButton) {
        playSound()
        runningNumber = ""
        //leftValStr = ""
        //rightValStr = ""
        counterLbl.text = String(0)
    }
    
    func playSound(){
        if btnSound.playing{
            btnSound.stop()
        }
        btnSound.play()
    }


}

