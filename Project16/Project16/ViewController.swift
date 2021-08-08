//
//  ViewController.swift
//  Project16
//
//  Created by JEONGSEOB HONG on 2021/08/07.
//

import UIKit
import MapKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        let london = Capital(title: "London",
                             coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
                             info: "Home to the 2012 Summer Olympics")
        let oslo = Capital(title: "Oslo",
                           coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75),
                           info: "Founded over a thousand year ago")
        let paris = Capital(title: "Paris",
                            coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508),
                            info: "Often called the City of Light")
        let rome = Capital(title: "Rome",
                           coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5),
                           info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC",
                                 coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667),
                                 info: "Named after George himself.")
        let tokyo = Capital(title: "Tokyo",
                            coordinate: CLLocationCoordinate2D(latitude:  35.652832, longitude:  139.839478),
                            info: "Hong's living capital")
        
        mapView.addAnnotation(london)
        mapView.addAnnotation(oslo)
        mapView.addAnnotation(paris)
        mapView.addAnnotation(rome)
        mapView.addAnnotation(washington)
        mapView.addAnnotation(tokyo)
        //        mapView.addAnnotations([london, oslo, paris, rome, washington, tokyo])
    }
    
    func setupNavigationBar() {
        title = "standard".uppercased()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                            target: self,
                                                            action: #selector(alertMapType))
    }
    
    @objc func alertMapType() {
        let alertController = UIAlertController(title: "Map Type",
                                                message: "Select shown map type",
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "standard",
                                                style: .default,
                                                handler: changeMapType))
        
        alertController.addAction(UIAlertAction(title: "satellite",
                                                style: .default,
                                                handler: changeMapType))
        
        alertController.addAction(UIAlertAction(title: "hybrid",
                                                style: .default,
                                                handler: changeMapType))
        
        alertController.addAction(UIAlertAction(title: "satelliteFlyover",
                                                style: .default,
                                                handler: changeMapType))
        
        alertController.addAction(UIAlertAction(title: "hybridFlyover",
                                                style: .default,
                                                handler: changeMapType))
        
        alertController.addAction(UIAlertAction(title: "mutedStandard",
                                                style: .default,
                                                handler: changeMapType))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    func changeMapType(action: UIAlertAction) -> Void {
        guard let mapTypeString = action.title else { return }
        var mapType: MKMapType = .standard
        
        switch mapTypeString {
        case "standard":
            mapType = .standard
        case "satellite":
            mapType = .satellite
        case "hybrid":
            mapType = .hybrid
        case "satelliteFlyover":
            mapType = .satelliteFlyover
        case "hybridFlyover":
            mapType = .hybridFlyover
        case "mutedStandard":
            mapType = .mutedStandard
        default:
            break
        }
        
        mapView.mapType = mapType
        title = mapTypeString
    }
    
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.pinTintColor = .green
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        presentWebView(capitalName: capital.title)
    }
    
    func presentWebView(capitalName: String?) {
        guard let capitalName = capitalName,
              let url = URL(string: "https://en.wikipedia.org/wiki/\(capitalName)")
        else { return }
        
        let webViewController = WebViewController(url: url)
        
        present(webViewController, animated: true)
    }
    
}
