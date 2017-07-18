//
//  LocationSpec.swift
//  TrackLocations
//
//  Created by Ya Kao on 7/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import TrackLocations

class LocationSpec: QuickSpec {
    override func spec() {
        describe("location") {
            it("can init with param"){
                let latitude: Double = 37.794647
                let longitude: Double = -122.392886
                let location = Location(latitude: latitude, longitude: longitude, name: "Ferry building")
                
                expect(location.latitude) == latitude
                expect(location.longitude) == longitude
                expect(location.name) == "Ferry building"
                
            }
            
            it("is equatable"){
                let location1 = Location(latitude: 37.794647, longitude: -122.392886, name: "")
                let location2 = Location(latitude: 37.794647, longitude: -122.392886, name: "")
                let location3 = Location(latitude: 37.788332, longitude: -122.407487, name: "")
                
                expect(location1 == location2) == true
                expect(location2 != location3) == true
            }
            
        }
    }
}
