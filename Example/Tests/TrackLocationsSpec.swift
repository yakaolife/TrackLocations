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
                        expect(locations).toNot(beNil())
                        
                        if let loc = locations{
                            expect(loc.count) == 3
                            for l in loc{
                                if l.name == "SF Ferry Building"{
                                    expect(l.latitude) == 37.795545
                                    expect(l.longitude) == -122.392967
                                }else if l.name == "Iterable"{
                                    expect(l.latitude) == 37.782923
                                    expect(l.longitude) == -122.398377
                                }else if l.name == "SF MOMA"{
                                    expect(l.latitude) == 37.78595
                                    expect(l.longitude) == -122.401081
                                }else{
                                    print("This test case failed, data isn't loading correctly")
                                    expect(true) == false
                                }
                            }
                        }

                        done()
                    })
                })

            }
            it("can return error from loading"){
                waitUntil(action: { done in
                    Tracker.load(requestURL: "https://mylocations-cc913.firebaseio.com/wrongURL", callback: { (success, locations, error) in
                        expect(success) == false
                        expect(locations).to(beNil())
                        expect(error) == TrackLocationsError.RequestError
                        done()
                    })

                })
            }
            it("can return error from JSON parsing"){
                waitUntil(action: { done in
                    Tracker.load(requestURL: "https:/mylocations-cc913.firebaseio.com/wrongJSON.json", callback: { (success, locations, error) in
                        expect(success) == false
                        expect(locations).to(beNil())
                        expect(error) == TrackLocationsError.JSONError
                        done()
                    })
                })

            }
            it("can return error from incompatible format"){
                waitUntil(action: { done in
                    Tracker.load(requestURL: "https:/mylocations-cc913.firebaseio.com/wrongFormat.json", callback: { (success, locations, error) in
                        expect(success) == false
                        expect(locations).to(beNil())
                        expect(error)  == TrackLocationsError.FormatError
                        done()
                    })
                })

            }
            
            it("can track locations"){
                
            }
            
            
        }
    }
}
