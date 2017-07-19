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
                    
                    Tracker.load(requestURL: "https://mylocations-cc913.firebaseio.com/testing.json", callback: { (success, locations, error) in
                        expect(success) == true
                        expect(error) == TrackLocationsError.NoError
                        done()
                    })
                })

            }
            it("can return error from loading"){
                waitUntil(action: { done in
                    Tracker.load(requestURL: "https://mylocations-cc913.firebaseio.com/wrongURL", callback: { (success, locations, error) in
                        expect(success) == false
                        expect(locations) == nil
                        expect(error) == TrackLocationsError.RequestError
                        done()
                    })

                })
            }
            it("can return error from JSON parsing"){
                waitUntil(action: { done in
                    Tracker.load(requestURL: "https:/mylocations-cc913.firebaseio.com/wrongJSON.json", callback: { (success, locations, error) in
                        expect(success) == false
                        expect(locations) == nil
                        expect(error) == TrackLocationsError.JSONError
                        done()
                    })
                })

            }
            it("can return error from incompatible format"){
                waitUntil(action: { done in
                    Tracker.load(requestURL: "https:/mylocations-cc913.firebaseio.com/wrongFormat.json", callback: { (success, locations, error) in
                        expect(success) == false
                        expect(locations) == nil
                        expect(error)  == TrackLocationsError.FormatError
                        done()
                    })
                })

            }
            
            
        }
    }
}
