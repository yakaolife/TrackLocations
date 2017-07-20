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
import CoreLocation

public enum TrackLocationsError : Int{
    case NoError
    case RequestError
    case JSONError
    case FormatError
    case NoServiceError
    case PermissionError
}

public let Tracker = TrackLocations.sharedInstance

public class TrackLocations: NSObject, CLLocationManagerDelegate{


    static let sharedInstance : TrackLocations = {
        return TrackLocations()
    }()
    
    public var enterRegionCallback : (Location) -> Void = { arg in }
    public var trackRegionErrorCallback: (Location?, Error) -> Void = { arg in }
    
    public func load(requestURL: String, callback: @escaping (Bool, [Location]?, TrackLocationsError)->Void){
        print("Calling load function!")
        
        Alamofire.request(requestURL).responseJSON { (response) in
            print("Response: \(String(describing: response.response))")
            print("Result: \(response.result)")
            
            guard response.result.isSuccess else{
                print("Error during url request: \(String(describing: response.result.error))")
                callback(false, nil, TrackLocationsError.RequestError)
                return
            }
            
            if let jsonData = response.data{
                let jsonObj = JSON(data: jsonData)
                
                var locations = [Location]()
                
                for (_, subJson) in jsonObj["locations"]{
                    guard let latitude = subJson["latitude"].double else{
                        callback(false, nil, TrackLocationsError.FormatError)
                        return
                    }
                    guard let longitude = subJson["longitude"].double else{
                        callback(false, nil, TrackLocationsError.FormatError)
                        return
                    }
                    guard let name = subJson["name"].string else{
                        callback(false, nil, TrackLocationsError.FormatError)
                        return
                    }
                    
                    let loc = Location(latitude: latitude, longitude: longitude, name: name)
                    locations.append(loc)
                }
                
                if let jsonString = response.result.value{
                    print("JSON: \(jsonString)")
                }
                callback(true, locations,TrackLocationsError.NoError)
                return
                
            }
            
            callback(false, nil, TrackLocationsError.JSONError)
            
        }
        
    }

    
    //Use location manager to track location
    public func track(location: Location)->TrackLocationsError{
        //Create region
        let coordinates = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let trueRadius = min(location.radius, locationManager.maximumRegionMonitoringDistance)
        let region: CLCircularRegion = CLCircularRegion(center: coordinates, radius: trueRadius, identifier: location.name)
        region.notifyOnEntry = true
        region.notifyOnExit = false
        
        //Check all sorts of permissions
        guard CLLocationManager.locationServicesEnabled() else{
            print("Location services not enabled")
            return TrackLocationsError.NoServiceError
        }
        guard CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) else{
            print("Location monitoring unavailable")
            return TrackLocationsError.NoServiceError
        }
        guard CLLocationManager.authorizationStatus() == .authorizedAlways else{
            
            print("Do not have authorization (Always) for monitoring location")
            return TrackLocationsError.PermissionError
        }
        
        //Add region to monitoring
        locationManager.startMonitoring(for: region)
        return TrackLocationsError.NoError
        
    }
    
    //MARK: CLLocationManager Delegate 
    public func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion){
        print("Entering \(region.identifier)")
        let circularRegion = region as! CLCircularRegion
        let location = Location(latitude: circularRegion.center.latitude, longitude: circularRegion.center.longitude, name: circularRegion.identifier)
        location.radius = circularRegion.radius
        
        enterRegionCallback(location)
    }
    
    public func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error){
        print("Monitoring failed! Error: \(error)")
        if let region = region{
            if let circularRegion = region as? CLCircularRegion{
                let location = Location(latitude: circularRegion.center.latitude, longitude: circularRegion.center.longitude, name: circularRegion.identifier)
                location.radius = circularRegion.radius
                trackRegionErrorCallback(location, error)
                return
            }
        }
        
        trackRegionErrorCallback(nil, error)
        
    }
    
    //TODO?
    //public func stopTracking(location: Location)
    
    //MARK: - Private stuff
    private var locationManager: CLLocationManager
    
    private override init(){
        self.locationManager = CLLocationManager()
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
    }
    
}
