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
    
   
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        DispatchQueue.main.async {
            self.lastKnownLocation = newLocation.coordinate
        }
    }
}

