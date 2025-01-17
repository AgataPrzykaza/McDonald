//
//  Location.swift
//  McDonald
//
//  Created by Agata Przykaza on 08/11/2024.
//
import Foundation
import MapKit

struct RestaurantLocation: Identifiable, Codable {
    
    var id: String
    let name: String
    let latitude: Double
    let longitude: Double
    let address: String
    let openHours: [String: String]
    let services: [String]
    
    var coordinate: CLLocationCoordinate2D{
        .init(latitude: latitude, longitude: longitude)
    }
    
    init(id: String,name: String,latitude: Double, longitude: Double , address: String, openHours: [String: String], services: [String]) {
            self.id = id
            self.name = name
            self.latitude = latitude
            self.longitude = longitude
            self.address = address
            self.openHours = openHours
            self.services = services
        }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case latitude
        case longitude
        case address
        case openHours
        case services
    }
}

//var mockRestaurants: [RestaurantLocation] = [
//    RestaurantLocation(
//        id: "1",
//        name: "Warszawa Centrum",
//        latitude: 52.2297,
//        longitude: 21.0122,
//        address: "ul. Marszałkowska 100, Warszawa",
//        openHours: [
//            "Monday": "8:00 AM - 10:00 PM",
//            "Tuesday": "8:00 AM - 10:00 PM",
//            "Wednesday": "8:00 AM - 10:00 PM",
//            "Thursday": "8:00 AM - 10:00 PM",
//            "Friday": "8:00 AM - 11:00 PM",
//            "Saturday": "9:00 AM - 11:00 PM",
//            "Sunday": "9:00 AM - 10:00 PM"
//        ],
//        services: ["McDrive", "McCafe"]
//    ),
//    RestaurantLocation(
//        id: "2",
//        name: "Praga Południe",
//        latitude: 52.2397,
//        longitude: 21.0222,
//        address: "ul. Grochowska 200, Warszawa",
//        openHours: [
//            "Monday": "8:00 AM - 10:00 PM",
//            "Tuesday": "8:00 AM - 10:00 PM",
//            "Wednesday": "8:00 AM - 10:00 PM",
//            "Thursday": "8:00 AM - 10:00 PM",
//            "Friday": "8:00 AM - 11:00 PM",
//            "Saturday": "9:00 AM - 11:00 PM",
//            "Sunday": "9:00 AM - 10:00 PM"
//        ],
//        services: ["McDelivery", "McCafe"]
//    ),
//    RestaurantLocation(
//        id: "3",
//        name: "Kraków Rynek",
//        latitude: 50.0619,
//        longitude: 19.9368,
//        address: "Rynek Główny 1, Kraków",
//        openHours: [
//            "Monday": "7:00 AM - 11:00 PM",
//            "Tuesday": "7:00 AM - 11:00 PM",
//            "Wednesday": "7:00 AM - 11:00 PM",
//            "Thursday": "7:00 AM - 11:00 PM",
//            "Friday": "7:00 AM - 12:00 AM",
//            "Saturday": "8:00 AM - 12:00 AM",
//            "Sunday": "8:00 AM - 11:00 PM"
//        ],
//        services: ["McDelivery", "McCafe","Śniadania"]
//    ),
//    RestaurantLocation(
//        id: "4",
//        name: "Poznań Stary Browar",
//        latitude: 52.4064,
//        longitude: 16.9252,
//        address: "ul. Półwiejska 42, Poznań",
//        openHours: [
//            "Monday": "9:00 AM - 10:00 PM",
//            "Tuesday": "9:00 AM - 10:00 PM",
//            "Wednesday": "9:00 AM - 10:00 PM",
//            "Thursday": "9:00 AM - 10:00 PM",
//            "Friday": "9:00 AM - 11:00 PM",
//            "Saturday": "10:00 AM - 11:00 PM",
//            "Sunday": "10:00 AM - 10:00 PM"
//        ],
//        services: ["McDelivery", "McCafe","Otwarte"]
//    ),
//    RestaurantLocation(
//        id: "5",
//        name: "Wrocław Sky Tower",
//        latitude: 51.0974,
//        longitude: 17.0242,
//        address: "ul. Powstańców Śląskich 95, Wrocław",
//        openHours: [
//            "Monday": "7:00 AM - 10:00 PM",
//            "Tuesday": "7:00 AM - 10:00 PM",
//            "Wednesday": "7:00 AM - 10:00 PM",
//            "Thursday": "7:00 AM - 10:00 PM",
//            "Friday": "7:00 AM - 11:00 PM",
//            "Saturday": "8:00 AM - 11:00 PM",
//            "Sunday": "8:00 AM - 10:00 PM"
//        ],
//        services: ["McDelivery", "McCafe"]
//    ),
//    RestaurantLocation(
//        id: "6",
//        name: "Gdańsk Starówka",
//        latitude: 54.3520,
//        longitude: 18.6466,
//        address: "ul. Długa 1, Gdańsk",
//        openHours: [
//            "Monday": "7:00 AM - 12:00 AM",
//            "Tuesday": "7:00 AM - 12:00 AM",
//            "Wednesday": "7:00 AM - 12:00 AM",
//            "Thursday": "7:00 AM - 12:00 AM",
//            "Friday": "24 hours",
//            "Saturday": "24 hours",
//            "Sunday": "7:00 AM - 12:00 AM"
//        ],
//        services: ["McDelivery", "McCafe","Zamów i odbierz"]
//    ),
//    RestaurantLocation(
//        id: "7",
//        name: "Łódź Manufaktura",
//        latitude: 51.7769,
//        longitude: 19.4543,
//        address: "ul. Drewnowska 58, Łódź",
//        openHours: [
//            "Monday": "8:00 AM - 10:00 PM",
//            "Tuesday": "8:00 AM - 10:00 PM",
//            "Wednesday": "8:00 AM - 10:00 PM",
//            "Thursday": "8:00 AM - 10:00 PM",
//            "Friday": "8:00 AM - 11:00 PM",
//            "Saturday": "9:00 AM - 11:00 PM",
//            "Sunday": "9:00 AM - 10:00 PM"
//        ],
//        services: ["McDelivery", "McCafe","Otwarte"]
//    ),
//    RestaurantLocation(
//        id: "8",
//        name: "Katowice Silesia",
//        latitude: 50.2610,
//        longitude: 19.0238,
//        address: "ul. Chorzowska 107, Katowice",
//        openHours: [
//            "Monday": "8:00 AM - 11:00 PM",
//            "Tuesday": "8:00 AM - 11:00 PM",
//            "Wednesday": "8:00 AM - 11:00 PM",
//            "Thursday": "8:00 AM - 11:00 PM",
//            "Friday": "8:00 AM - 12:00 AM",
//            "Saturday": "9:00 AM - 12:00 AM",
//            "Sunday": "9:00 AM - 11:00 PM"
//        ],
//        services: ["McDelivery", "McDrive","Otwarte"]
//    ),
//    RestaurantLocation(
//        id: "9",
//        name: "Bydgoszcz Focus",
//        latitude: 53.1235,
//        longitude: 18.0076,
//        address: "ul. Jagiellońska 39-47, Bydgoszcz",
//        openHours: [
//            "Monday": "8:00 AM - 10:00 PM",
//            "Tuesday": "8:00 AM - 10:00 PM",
//            "Wednesday": "8:00 AM - 10:00 PM",
//            "Thursday": "8:00 AM - 10:00 PM",
//            "Friday": "8:00 AM - 11:00 PM",
//            "Saturday": "9:00 AM - 11:00 PM",
//            "Sunday": "9:00 AM - 10:00 PM"
//        ],
//        services: ["McDelivery", "McCafe","Otwarte"]
//    ),
//    RestaurantLocation(
//        id: "10",
//        name: "Szczecin Galaxy",
//        latitude: 53.4289,
//        longitude: 14.5530,
//        address: "al. Wyzwolenia 18, Szczecin",
//        openHours: [
//            "Monday": "8:00 AM - 10:00 PM",
//            "Tuesday": "8:00 AM - 10:00 PM",
//            "Wednesday": "8:00 AM - 10:00 PM",
//            "Thursday": "8:00 AM - 10:00 PM",
//            "Friday": "8:00 AM - 11:00 PM",
//            "Saturday": "9:00 AM - 11:00 PM",
//            "Sunday": "9:00 AM - 10:00 PM"
//        ],
//        services: ["McDelivery", "McCafe","Otwarte"]
//    )
//]
//
//
