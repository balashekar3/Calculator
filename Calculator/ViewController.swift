//
//  ViewController.swift
//  Calculator
//
//  Created by BALA SEKHAR on 03/09/20.
//  Copyright © 2020 BALU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var allButtons:[UIButton]!
    @IBOutlet var allNumbers:[UIButton]!
    
    @IBOutlet weak var numberLabel: UILabel!
  
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var plusminusButton: UIButton!
    @IBOutlet weak var percentButton: UIButton!
    
    @IBOutlet weak var equalsButton: UIButton!
    @IBOutlet weak var additionButton: UIButton!
    @IBOutlet weak var subtractionButton: UIButton!
    @IBOutlet weak var multiplicationButton: UIButton!
    @IBOutlet weak var divisionButton: UIButton!
    
    private var numberOnScreen:Double=0
    private var previousNumber:Double=0
    private var isOperatorSelected:Bool=false
    private var operation=0
    private var result:Double=0
    private var firstNumberInIndex:Bool=false
    


    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in allButtons{
            button.layer.cornerRadius=40
            button.addTarget(self, action: #selector(configureButton(sender:)), for: .touchUpInside) //send all numbers to this method
        }
        numberLabel.adjustsFontSizeToFitWidth=true
    }

    private func checkIfInt(result:Double){
            let isInteger=floor(result)==result
            if isInteger {
                if result >= Double(Int.max) || result <= Double(Int.min){
                numberLabel.text="Error"
            }else{
                numberLabel.text=String(Int(result))
            }
        
        }//isInteger-end
            else{
                numberLabel.text=String(round(10000 * result) / 10000)//10000 for 4 decimals
        }
    }//checkIfInt-end

    
    @objc private func configureButton(sender:UIButton){
        
        switch sender.tag{
        case 0,1,2,3,4,5,6,7,8,9: //Numbers
            
            if isOperatorSelected{
                if firstNumberInIndex{
                    numberLabel.text=numberLabel.text! + String(sender.tag)
                    numberOnScreen=Double(numberLabel.text!)!
                }else{
                    numberLabel.text=""
                    numberLabel.text=String(sender.tag)
                    numberOnScreen=Double(numberLabel.text!)!
                    firstNumberInIndex=true
                }
            }else{
                if numberLabel.text == "0"{
                    numberLabel.text=String(sender.tag)
                    numberOnScreen=Double(numberLabel.text!)!
                }else if numberLabel.text == "-0"{
                    numberLabel.text="-" + String(sender.tag)
                    numberOnScreen=Double(numberLabel.text!)!
                }else if numberLabel.text != "0" || numberLabel.text != "-0"{
                    numberLabel.text=numberLabel.text! + String(sender.tag)
                    numberOnScreen=Double(numberLabel.text!)!
            }
       
        }//isOperatorSelected-end
        case 10://=
            isOperatorSelected=false
            switch operation {
            case 11://add
                result += numberOnScreen
                checkIfInt(result: result)//Check it is whole number or not
            case 12://subtract
                result -= numberOnScreen
                checkIfInt(result: result)
            case 13://multiply
                result *= numberOnScreen
                checkIfInt(result: result)
            case 14://divide
                result /= numberOnScreen
                checkIfInt(result: result)
            default:
                break
            }
        case 11,12,13,14:
            result=Double(numberLabel.text!)!
            numberOnScreen=Double(numberLabel.text!)!
            isOperatorSelected=true
            firstNumberInIndex=false
            operation=sender.tag
        case 15:// AC Set everything back to default
            isOperatorSelected=false
            operation=0
            numberOnScreen=0
            result=0
            numberLabel.text="0"
            firstNumberInIndex=false
        case 16: //+/-
            if (numberLabel.text?.contains("-"))!{
                var string=numberLabel.text
                string!.remove(at: string!.startIndex)
                numberLabel.text=string
            }else{
                var string=numberLabel.text
                string!.insert("-", at: string!.startIndex)
                numberLabel.text=string

            }
        case 17://%
            let numberPercentage=String(Double(numberLabel.text!)!/100)
            numberLabel.text=numberPercentage
            numberOnScreen=Double(numberLabel.text!)!
        case 18://.
            if !(numberLabel.text?.contains("."))!{
                numberLabel.text=numberLabel.text! + "."
            }
            
        default:
            break
        }//switch-end
    }//configureButton-end
}
