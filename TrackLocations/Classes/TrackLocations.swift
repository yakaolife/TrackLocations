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
    public static func load(requestURL: String, callback: @escaping (Bool, Error?)->Void){
        print("Calling load function!")
        
        Alamofire.request(requestURL).responseJSON { (response) in
            print("Response: \(String(describing: response.response))")
            print("Result: \(response.result)")
            
            guard response.result.isSuccess else{
                print("Error during url request: \(String(describing: response.result.error))")
                callback(false, response.result.error)
                return
            }
            
            if let json = response.result.value{
                print("JSON: \(json)")
            }
            
            callback(true, nil)
            
        }
        
    }
    
    public static func testFunc(){
        print("This is just testing if we actually called TrackLocations!")
    }
    
    var locations = [Location]()
    
    //TODO: unit
    var radius = 100
}
