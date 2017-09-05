//
//  MapViewController.swift
//  ShuttleServiceApp
//
//  Created by Nikhil Prashar on 12/5/16.
//  Copyright © 2016 Nikhil Prashar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    // all the addresses will be converted to coordinates and will be stored in this variable 
    // along with the name of the student
    var locations = [(CLLocationCoordinate2D, String)]()
    
    // map view outlet
    @IBOutlet var mapView: MKMapView!
    
    // used for address conversion to coordinates
    var geocoder : CLGeocoder!
    static var count = 0
    static var Address_count = 0
    var latitude = [CLLocationDegrees]()
    var longitutde = [CLLocationDegrees]()
    var name_Student_1 = [String]()
    var name_Student = [String]()
    
    // results form TimeSelectedController page.
    var arrayOfItemsFromPreviousView = [RegisterItem]()
    var address = [String]()
    
    // this will have all the computed shortest distances along with the name of the student
    var shortest_Distance_Locations = [(CLLocationCoordinate2D, String)]()
    
    var location : (CLLocationCoordinate2D, String)? = nil
    var cityAddress : String = "Syracuse, NY, 13210"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // initial location coordinates are hard coded, as the initial location will always be the same
        latitude.append(43.039925) // driver
        longitutde.append(-76.130950)
        
        self.name_Student.append("Driver") // title for initial location
        
        // rest all the addresses will be added as per the registrations
        for item in arrayOfItemsFromPreviousView
        {
            address.append(item.address + cityAddress)
            self.name_Student_1.append(item.name)
            MapViewController.Address_count += 1
        }
        
        mapView.delegate = self
        self.geocoder = CLGeocoder()
        
        for i in 0..<address.count {
            
            getAddress(address[i], completion: {
                coordinate in
                self.latitude.append(coordinate.latitude)
                self.longitutde.append(coordinate.longitude)
                self.name_Student.append(self.name_Student_1[i])
                MapViewController.count=MapViewController.count + 1
                
                if( MapViewController.count == MapViewController.Address_count)
                { // this function will be called when the child thread will finish converting all addresses to 
                // coordinates and added them to an array
                    self.insertLocations()
                }
            })
        }
        
    }
    
    // this is helper function to implement forward geocoding
    // i.e. converting addresses to coordinates
    func getAddress (address: String, completion: (CLLocationCoordinate2D) -> Void ){
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if placemarks!.count > 0 {
                    let placemark = placemarks![0] as CLPlacemark
                    let cal_location = placemark.location
                    completion((cal_location?.coordinate)!)
                }
            }
        }
        
    }
    
    
    
    // this function will call the shortest distance function
    func insertLocations(){
        var sourceLocation = (CLLocationCoordinate2D(latitude: latitude[0], longitude: longitutde[0]), name_Student[0])  // if i is 0 -> this will be used
        for i in 0..<latitude.count{
            if (i == 0){
                location = (CLLocationCoordinate2D(latitude: latitude[i], longitude: longitutde[i]), name_Student[i])
                
            }
            else{
                let local_Loc = CLLocationCoordinate2D(latitude: latitude[i], longitude: longitutde[i])
                locations.append((local_Loc, name_Student[i]))
            }
        }
        
        let size_of_locations = locations.count
        
        for _ in 0..<size_of_locations{
            if let val = getClosestLocation(location!, locations: locations) {
                shortest_Distance_Locations.append(val) // shortest distance array
                
                self.locations = self.locations.filter( { $0.0.latitude != val.0.latitude } )
                self.locations = self.locations.filter( { $0.0.longitude != val.0.longitude } )
                
                if (locations.count == 0){
                    break
                }
                
            }
            
            
        }
        
        let size_of_shortest = shortest_Distance_Locations.count
        
        for i in 0..<size_of_shortest{
            var destinationLocation : (CLLocationCoordinate2D, String)? = nil
            if (i > 0){
                sourceLocation = (CLLocationCoordinate2D(latitude: shortest_Distance_Locations[i-1].0.latitude, longitude: shortest_Distance_Locations[i-1].0.longitude), shortest_Distance_Locations[i-1].1)
            }
            
            
            destinationLocation = (CLLocationCoordinate2D(latitude: shortest_Distance_Locations[i].0.latitude, longitude: shortest_Distance_Locations[i].0.longitude), shortest_Distance_Locations[i].1)
            
            
            let sourcePlacemark = MKPlacemark(coordinate: sourceLocation.0, addressDictionary: nil)
            let destinationPlacemark = MKPlacemark(coordinate: destinationLocation!.0, addressDictionary: nil)
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
            
            // annotation used to display - pins, titles, sub-titles
            let sourceAnnotation = MKPointAnnotation()
            sourceAnnotation.title = sourceLocation.1
            if (i != 0){            // For driver there will not be any sub title
                sourceAnnotation.subtitle = String(i)
            }
            
            // assigning coordinates to the destination annotation
            if let location = sourcePlacemark.location {
                sourceAnnotation.coordinate = location.coordinate
            }
            
            
            let destinationAnnotation = MKPointAnnotation()
            destinationAnnotation.title = destinationLocation!.1
            if (i == size_of_shortest - 1){
                destinationAnnotation.subtitle = String(size_of_shortest)
            }
            
            // assigning coordinates to the destination annotation
            if let location = destinationPlacemark.location {
                destinationAnnotation.coordinate = location.coordinate
            }
            
            // add annotation on the map
            self.mapView.addAnnotations([sourceAnnotation,destinationAnnotation])
            
            
            // this is done to focus/zoom the map at the initial location when it first loads.
            if sourceLocation.0.latitude == 43.039925 {
                self.mapView.showAnnotations([sourceAnnotation, sourceAnnotation], animated: true)
                self.mapView.annotationVisibleRect
                
            }
            
            
            let directionRequest = MKDirectionsRequest()
            directionRequest.source = sourceMapItem
            directionRequest.destination = destinationMapItem
            directionRequest.transportType = .Automobile
            
            
            // Calculate the direction
            let directions = MKDirections(request: directionRequest)
            
            
            directions.calculateDirectionsWithCompletionHandler {
                (response, error) -> Void in
                
                guard let response = response else {
                    if let error = error {
                        print("Error: \(error)")
                    }
                    
                    return
                }
                // displaying route in the map
                // that is laying routes on the map
                for route in response.routes{
                    self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.AboveRoads)
                    
                }
            }
            
            
        }
        
    } 
    
    
    // this function calculates the shortest distance from an initial location
    func getClosestLocation(location: (CLLocationCoordinate2D, String), locations: [(CLLocationCoordinate2D, String)]) -> (CLLocationCoordinate2D, String)? {
        let first = MKMapPointForCoordinate(location.0)
        var closestLocation: (distance: Double, coordinates: CLLocationCoordinate2D, title: String)?
        
        for loc in locations{
            let second = MKMapPointForCoordinate(loc.0)
            let distance = MKMetersBetweenMapPoints(first, second)/1000
            
            if (closestLocation == nil){
                closestLocation = (distance, loc.0, loc.1 )
            }
            else{
                if distance < closestLocation!.distance{
                    closestLocation = (distance, loc.0, loc.1)
                }
            }
            
        }
        return (closestLocation!.coordinates, closestLocation!.title)
        
    }
    
    // this functio will display the routes
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.orangeColor()
        renderer.lineWidth = 4.0
        return renderer
    }
    
    
}












