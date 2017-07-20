//
//  Location.swift
//  Pods
//
//  Created by Ya Kao on 7/17/17.
//
//

import Foundation
import Alamofire
import SwiftyJSON

public class Location: Equatable{
    
    public let longitude : Double
    public let latitude : Double
    public let name: String //Will also use as identifier for region monitoring
    public var radius: Double = 1000 //In meters
    
    public required init(latitude: Double, longitude: Double, name: String) {
        self.longitude = longitude
        self.latitude = latitude
        self.name = name
    }
    
    public init(_ dictionary : [String: Any]){
        self.longitude = dictionary["longitude"] as! Double
        self.latitude = dictionary["latitude"] as! Double
        self.name = dictionary["name"] as! String
    }
    
    // A place might have different names, so don't compare the name
    public static func ==(lhs: Location, rhs: Location) -> Bool{
        return lhs.longitude == rhs.longitude && lhs.latitude == rhs.latitude
    }
    
}

extension Location: CustomStringConvertible {
    public var description: String{
        return "\(name): latitude:\(latitude), longitude: \(longitude)"
    }
}
