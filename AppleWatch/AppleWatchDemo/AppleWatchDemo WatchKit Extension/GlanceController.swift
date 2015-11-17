//
//  GlanceController.swift
//  AppleWatchDemo WatchKit Extension
//
//  Created by 杜豪 on 15/1/14.
//  Copyright (c) 2015年 dh. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {

    @IBOutlet var txtDate: WKInterfaceDate!
    
    @IBOutlet var txtLocation: WKInterfaceLabel!
    
    @IBOutlet var map: WKInterfaceMap!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        txtLocation.setText("wuhanUniversty")
        
        map.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake(30.541093, 114.360734), MKCoordinateSpanMake(2.0, 2.0)))
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
