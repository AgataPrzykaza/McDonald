//
//  LocationManger.swift
//  McDonald
//
//  Created by Agata Przykaza on 08/01/2025.
//
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var lastKnownLocation: CLLocationCoordinate2D?
    private var manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
    }
    
    func checkLocationAuthorization() {
        switch manager.authorizationStatus {
        case .notDetermined:
            // Poproś o zgodę
            manager.requestWhenInUseAuthorization()
            
        case .restricted:
            print("Location access restricted.")
            
        case .denied:
            print("Location access denied. Please enable location in settings.")
            
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location access authorized.")
            manager.startUpdatingLocation()
            
        @unknown default:
            print("Unknown location authorization status.")
        }
    }
    
    // Wywoływane za każdym razem, gdy zmienia się status autoryzacji
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    // Wywoływane za każdym razem, gdy aktualizowana jest lokalizacja
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        DispatchQueue.main.async {
            self.lastKnownLocation = newLocation.coordinate
        }
    }
}

//import Foundation
//import CoreLocation
//import SwiftUI
//import MapKit
//
//final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
//    
//    @Published var lastKnownLocation: CLLocationCoordinate2D?
//    var manager = CLLocationManager()
//    
//  
//    func checkLocationAuthorization() {
//        
//        manager.delegate = self
//        manager.startUpdatingLocation()
//        
//        switch manager.authorizationStatus {
//        case .notDetermined://The user choose allow or denny your app to get the location yet
//            manager.requestWhenInUseAuthorization()
//            
//        case .restricted://The user cannot change this app’s status, possibly due to active restrictions such as parental controls being in place.
//            print("Location restricted")
//            
//        case .denied://The user dennied your app to get location or disabled the services location or the phone is in airplane mode
//            print("Location denied")
//            
//        case .authorizedAlways://This authorization allows you to use all location services and receive location events whether or not your app is in use.
//            print("Location authorizedAlways")
//            
//        case .authorizedWhenInUse://This authorization allows you to use all location services and receive location events only when your app is in use
//            print("Location authorized when in use")
//            lastKnownLocation = manager.location?.coordinate
//            
//        @unknown default:
//            print("Location service disabled")
//        
//        }
//    }
//    
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {//Trigged every time authorization status changes
//        checkLocationAuthorization()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        lastKnownLocation = locations.first?.coordinate
//    }
//}
