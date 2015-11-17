//
//  InterfaceController.swift
//  AppleWatchDemo WatchKit Extension
//
//  Created by 杜豪 on 15/1/14.
//  Copyright (c) 2015年 dh. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet var guessSlider: WKInterfaceSlider!         // the slider
    @IBOutlet var guessLabel: WKInterfaceLabel!     // the label displaying the guess number
    @IBOutlet var resultLabel: WKInterfaceLabel!    // Wrong/Correct Label
    
    var guessNumber:Int = 3

    @IBAction func updateGuess(value: Float) {
        guessNumber = Int(value * 5)
        guessLabel.setText("Your guess: \(guessNumber)")
    }
    
    @IBAction func startGuess() {
        var randomNumber = Int(arc4random_uniform(6))
        if(guessNumber == randomNumber) {
            resultLabel.setText("Correct. You win!")
        } else {
            resultLabel.setText("Wrong. The number is \(randomNumber)")
        }
    }

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        println("第一个界面awakeWithContext")
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        //这个方法可以让您知道该界面是否对用户可视。借助它来更新界面对象，以及完成相应的任务，完成任务只能在界面可视时使用。
        super.willActivate()
        println("willActivate")

    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        //使用didDeactivate方法来执行所有的清理任务。例如，使用此方法来废止计时器、停止动画或者停止视频流内容的传输。您不能在这个方法中设置界面控制器对象的值，在本方法被调用之后到willActivate方法再次被调用之前，任何更改界面对象的企图都是被忽略的。
        super.didDeactivate()
        println("didDeactivate")
    }

}
