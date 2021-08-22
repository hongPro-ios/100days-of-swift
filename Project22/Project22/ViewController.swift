//
//  ViewController.swift
//  Project22
//
//  Created by JEONGSEOB HONG on 2021/08/22.
//

import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var distanceMeterLabel: UILabel!
    @IBOutlet var distanceReadingLabel: UILabel!
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        //        locationManager?.requestWhenInUseAuthorization()
        
        view.backgroundColor = .gray
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
            if CLLocationManager.isRangingAvailable() {
                startScanning()
            }
        }
    }
    
    func startScanning() {
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconRegion = CLBeaconRegion(uuid: uuid, major: 123, minor: 456, identifier: "MyBeacon")
        
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(satisfying: beaconRegion.beaconIdentityConstraint)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        if let beacon = beacons.first {
            update(distance: beacon.proximity, accuracy: beacon.accuracy)
        } else {
            update(distance: .unknown)
        }
    }
    
    func update(distance: CLProximity, accuracy: CLLocationAccuracy = 0) {
        UIView.animate(withDuration: 1) {
            switch distance {
            case .immediate:
                self.view.backgroundColor = .green
                self.distanceReadingLabel.text = "RIGHT HERE"
                self.distanceMeterLabel.text = "\(round(accuracy*100)/100) Meter"
            case .near:
                self.view.backgroundColor = .orange
                self.distanceReadingLabel.text = "NEAR"
                self.distanceMeterLabel.text = "\(round(accuracy*100)/100) Meter"
            case .far:
                self.view.backgroundColor = .blue
                self.distanceReadingLabel.text = "FAR"
                self.distanceMeterLabel.text = "\(round(accuracy*100)/100) Meter"
            default:
                self.view.backgroundColor = .gray
                self.distanceReadingLabel.text = "UNKNOWN"
                self.distanceMeterLabel.text = "? Meter"
            }
        }
    }
    
}
