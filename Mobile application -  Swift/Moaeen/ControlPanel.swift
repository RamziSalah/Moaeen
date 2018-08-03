//
//  ViewController.swift
//  Where Am I
//
//  Created by Rob Percival on 13/03/2015.
//  Copyright (c) 2015 Appfish. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Cluster



class ControlPanel: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate , UICollectionViewDelegate , UICollectionViewDataSource {
    
    let names = ["حسام الدين محمد عمر", "خالد الحربي", "ايمن السروري"]
       let statuses = ["مستلم",
                       "غير مستلم"
        ,
        "غير مستلم"]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell :VCollectionViewCell  = collectionView.dequeueReusableCell(withReuseIdentifier: "Vcell", for: indexPath) as! VCollectionViewCell
        
        cell.name.text = names[indexPath.row]
        cell.status.text =  statuses[indexPath.row]
        
        
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.black.cgColor
        
        if (indexPath.row == 0 ){
           cell.startOrder.setTitle("انتهاء الطلب",for: .normal)
        }
        
        cell.startOrder.addTarget(self, action: #selector(self.BtnAction(_:)), for: .touchUpInside)
        
//        cell.Contact.addTarget(self, action: Selector(("buttonClicked:")), for: UIControlEvents.touchUpInside)
        
        return cell
    }
    
    
    @objc func BtnAction(_ sender: Any)
    {
        
          performSegue(withIdentifier: "toCreatRequest", sender: self)
        
        let buttonRow = (sender as AnyObject).tag
    }
//    
//    func buttonClicked(_ sender : UIButton) {
//        
//          performSegue(withIdentifier: "toCreatRequest", sender: self)
//        
//    }
    
    @IBOutlet var map: MKMapView!
    
    var manager:CLLocationManager!
    
    var annotation = MKPointAnnotation()
    
    @IBOutlet weak var confermLocation: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        self.map.showsUserLocation = true
        
        
    }
    
    //NOTE: [AnyObject] changed to [CLLocation]
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
 
        
        let userLocation:CLLocation = locations[0]

        let latitude:CLLocationDegrees = userLocation.coordinate.latitude

        let longitude:CLLocationDegrees = userLocation.coordinate.longitude

        let latDelta:CLLocationDegrees = 0.01

        let lonDelta:CLLocationDegrees = 0.01

        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)

        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)

        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)

        map.setRegion(region, animated: false)

        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
      
       map.addAnnotation(annotation)
        
      
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confermLoc(_ sender: Any) {
        
        performSegue(withIdentifier: "toCreatRequest", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toCreatRequest" {
            let destinationVC = segue.destination as! Request
            
            
            destinationVC.request.latitude  = "21.40474"
            destinationVC.request.longitude = "39.892742"
        }
        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "myAnnotation") as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
        } else {
            annotationView?.annotation = annotation
        }
        
        if let annotation = annotation as? MyPointAnnotation {
            annotationView?.pinTintColor = annotation.pinTintColor
        }
        
        return annotationView
    }
    
    
}

