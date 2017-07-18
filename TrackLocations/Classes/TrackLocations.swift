//
//  TrackLocations.swift
//  Pods
//
//  Created by Ya Kao on 7/17/17.
//
//

import Foundation
import Alamofire
import SwiftyJSON

public class TrackLocations{
    public static func load(requestURL: String, callback: (Bool, Error?)->Void){
        
        callback(false, nil)
    }
    
    //var locations = [Location]()
    
    //TODO: unit
    var radius = 100
}
