//
//  NotificationController.swift
//  AppleWatchDemo WatchKit Extension
//
//  Created by 杜豪 on 15/1/14.
//  Copyright (c) 2015年 dh. All rights reserved.
//

import WatchKit
import Foundation


class NotificationController: WKUserNotificationInterfaceController {

    @IBOutlet var dynamicLabel: WKInterfaceLabel!
    
    override init() {
        // Initialize variables here.
        super.init()
        
        // Configure interface objects here.
    }

    override func willActivate() {
        println("Notfication >willActivate")
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    /*
    override func didReceiveLocalNotification(localNotification: UILocalNotification, withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        // This method is called when a local notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification inteface as quickly as possible.
        //
        // After populating your dynamic notification interface call the completion block.
        completionHandler(.Custom)
    }
    */
    
    //要将模拟器切换为显示动态通知，必须把这段注释取消
    override func didReceiveRemoteNotification(remoteNotification: [NSObject : AnyObject], withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        // This method is called when a remote notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification inteface as quickly as possible.
        //
        // After populating your dynamic notification interface call the completion block.
        let mount=1.2 //此值根据你的应用计算生成
        dynamicLabel.setText("Today you should drink \(mount)L water more.")
        completionHandler(.Custom)
    }
    
}
