//
//  TwoInterfaceController.swift
//  AppleWatchDemo
//
//  Created by 杜豪 on 15/2/12.
//  Copyright (c) 2015年 dh. All rights reserved.
//

import WatchKit
import Foundation


class TwoInterfaceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        println("第二个界面 awakeWithContext")
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
