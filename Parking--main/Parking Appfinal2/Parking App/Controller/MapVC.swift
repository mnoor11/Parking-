//
//  MapVC.swift
//  Parking App
//
//  Created by PC on 25/04/1443 AH.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let locations = [Location(locationName: "High City", latitude: 18.20446103246267, longitude: 42.496804468507854),
                     Location(locationName: "Airport Garden", latitude: 18.241456594162667, longitude: 42.64542814568659),
                     Location(locationName: "Abha View", latitude: 18.23936783858459, longitude: 42.58171403073459)]

    var annotations = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(mapView)
        mapView.delegate = self
        
        for i in self.locations {
            let annotation = MKPointAnnotation()
            annotation.title = i.locationName
            annotation.coordinate = CLLocationCoordinate2D(latitude: i.latitude , longitude: i.longitude)
                self.annotations.append(annotation)
                self.mapView.addAnnotations(self.annotations)
        }
        
        //Zoom to Abha location
        let abhaLocation = CLLocationCoordinate2D(latitude: 18.23636523613213, longitude: 42.5489029967122)
        let viewRegion = MKCoordinateRegion(center: abhaLocation, latitudinalMeters: 22000, longitudinalMeters: 22000)
        mapView.setRegion(viewRegion, animated: true)
    }
    

    lazy var mapView : MKMapView = {
        $0.frame = self.view.bounds
        $0.delegate = self
        return $0
    }(MKMapView())
   
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation //as? Location
//        print(annotation?.title)
        guard let latitude = annotation?.coordinate.latitude, let longitude = annotation?.coordinate.longitude else {return}
              
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.openURL(URL(string:"comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving")!)
            
        } else {
//            NSLog("Can't use comgooglemaps://");
            if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving") {
                UIApplication.shared.open(urlDestination)
            }
        }
                  
    }
    

}
