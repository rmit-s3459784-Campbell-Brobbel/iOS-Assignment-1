//: Playground - noun: a place where people can play

import UIKit
import CoreLocation
import MapKit
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
let geocoder = CLGeocoder()

geocoder.geocodeAddressString("Ringwood Basketball Stadium, Ringwood, AU", completionHandler: { placemarks, error in
    
    print(placemarks!.first!)
})

let request = MKLocalSearchRequest()
request.naturalLanguageQuery = "Knox Basketball Stadium, Boronia, AU"

let search = MKLocalSearch(request: request)
search.start(completionHandler: {response , error in
    print(response!.mapItems.first)
})
let d1 = Date(timeIntervalSince1970: 0)
let date = Date(timeIntervalSince1970: 86400000)