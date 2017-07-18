//
//  TrackLocationsSpec.swift
//  TrackLocations
//
//  Created by Ya Kao on 7/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import Alamofire
import SwiftyJSON
import TrackLocations

class TrackLocationsSpec: QuickSpec {
    override func spec() {
        describe("trackLocation func") {
        
            it("can load data from firebase"){
                waitUntil(action: { done in
                    TrackLocations.load(requestURL: "https://mylocations-cc913.firebaseio.com/testing.json", callback: { (success, error) in
                        expect(success) == true
                        expect(error == nil) == true
                        done()
                    })
                })

            }
//            it("can return error from loading"){
//                TrackLocations.load(requestURL: "https://mylocations-cc913.firebaseio.com/wrongURL", callback: { (success, error) in
//                    expect(success) == false
//                    //expect(error) == TrackLocations.LoadError
//                })
//            }
//            it("can return error from JSON parsing"){
//                TrackLocations.load(requestURL: "https:/mylocations-cc913.firebaseio.com/wrongJSON", callback: { (success, error) in
//                    expect(success) == false
//                    //expect(error) == TrackLocations.JSONError
//                })
//            }
//            it("can return error from incompatible format"){
//                TrackLocations.load(requestURL: "https:/mylocations-cc913.firebaseio.com/wrongFormat", callback: { (success, error) in
//                    expect(success) == false
//                    //expect(error) == TrackLocations.FormatError
//                })
//            }
            
            
        }
    }
}
