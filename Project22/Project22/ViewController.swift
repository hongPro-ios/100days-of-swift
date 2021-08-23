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
    @IBOutlet var indicateCircleView: UIView!
    @IBOutlet var beaconLocationLabel: UILabel!
    
    var locationManager: CLLocationManager?
    var isFirst = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        //        locationManager?.requestWhenInUseAuthorization()
        
        view.backgroundColor = .gray
        
        indicateCircleView.layer.cornerRadius = 128
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
            if CLLocationManager.isRangingAvailable() {
                startScanning()
            }
        }
    }
    
    func startScanning() {
        let uuid1 = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconRegion1 = CLBeaconRegion(uuid: uuid1, identifier: "MyBeacon1_5A4BCFCE")
        
        let uuid2 = UUID(uuidString: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6")!
        let beaconRegion2 = CLBeaconRegion(uuid: uuid2, identifier: "MyBeacon2_2F234454")
        
        let uuid3 = UUID(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")!
        let beaconRegion3 = CLBeaconRegion(uuid: uuid3, identifier: "MyBeacon3_E2C56DB5")
        
        let beaconRegions = [beaconRegion1, beaconRegion2, beaconRegion3]
        
        beaconRegions.forEach { beaconRegion in
            locationManager?.startMonitoring(for: beaconRegion)
            locationManager?.startRangingBeacons(satisfying: beaconRegion.beaconIdentityConstraint)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        print(beacons)
        guard !beacons.isEmpty else { return }
        
        if let beacon = beacons.first {
            if isFirst {
                isFirst = false
                alertBeaconDetectedMessage()
            }
            beaconLocationLabel.text = beacon.uuid.uuidString
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
                self.indicateCircleView.transform = CGAffineTransform(scaleX: 1, y: 1)
                UIView.animate(withDuration: 0.2) {
                    self.indicateCircleView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                }
            case .near:
                self.view.backgroundColor = .orange
                self.distanceReadingLabel.text = "NEAR"
                self.distanceMeterLabel.text = "\(round(accuracy*100)/100) Meter"
                self.indicateCircleView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                UIView.animate(withDuration: 0.2) {
                    self.indicateCircleView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                }
            case .far:
                self.view.backgroundColor = .blue
                self.distanceReadingLabel.text = "FAR"
                self.distanceMeterLabel.text = "\(round(accuracy*100)/100) Meter"
                self.indicateCircleView.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
                UIView.animate(withDuration: 0.2) {
                    self.indicateCircleView.transform = CGAffineTransform(scaleX: 0.30, y: 0.30)
                }
            default:
                self.view.backgroundColor = .gray
                self.distanceReadingLabel.text = "UNKNOWN"
                self.distanceMeterLabel.text = "? Meter"
                self.indicateCircleView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                UIView.animate(withDuration: 0.2) {
                    self.indicateCircleView.transform = CGAffineTransform(scaleX: 0.010, y: 0.010)
                }
            }
        }
    }
    
    func alertBeaconDetectedMessage() {
        let alertController = UIAlertController(title: "Detected Your Beacon", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alertController, animated: true)
    }
    
}
