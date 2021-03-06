//
//  ViewController.swift
//  TrackLocations
//
//  Created by yakaolife@gmail.com on 07/17/2017.
//  Copyright (c) 2017 yakaolife@gmail.com. All rights reserved.
//

import UIKit
import TrackLocations

class ViewController: UIViewController {
    
    var locations : [Location]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Any call to Tracker will trigger asking user for location service permission
        
        //Set up the callbacks, depend on applications
        Tracker.enterRegionCallback = enterLocation(_:)
        Tracker.trackRegionErrorCallback = onErrorTracking(_:_:)
        
        print("Download a list of locations")
        Tracker.load(requestURL: "https://mylocations-cc913.firebaseio.com/testing.json") { (success, locations, error) in
            print("Success: \(success)")
            self.locations = locations
            
        }
    }
    
    func enterLocation(_ location: Location){
        print("Enter \(location.name)!")
        if UIApplication.shared.applicationState != .active{
            //create notification
            let note = UILocalNotification()
            note.alertBody = "Entering \(location.name)"
            UIApplication.shared.presentLocalNotificationNow(note)
        }
    }
    
    func onErrorTracking(_ location: Location?,_ error: Error){
        var name = "Unknown location"
        if let location = location{
            name = location.name
        }
        print("Tracking \(name) results in error: \(error)")
    }

    @IBAction func trackLocations(_ sender: UIButton) {
        
        for loc in self.locations!{
            print(loc)
            
            let result = Tracker.track(location: loc)
            switch(result){
            case TrackLocationsError.NoError:
                print("Successfully add \(loc.name) to track")
            default:
                print("Error: \(result)")
                
            }
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

