

import UIKit
import MapKit

class StudentViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print ("naya wala")
        // Do any additional setup after loading the view, typically from a nib.
        let coordinate = CLLocationCoordinate2DMake(38.9227, -77.0194)
        let span = MKCoordinateSpanMake(0.003, 0.003)
        let region = MKCoordinateRegionMake(coordinate, span)
        print(region)
        mapView.setRegion(region, animated:true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Swapnil Tamrakar"
        self.mapView.addAnnotation(annotation)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - MKMapView delegate
    
    // Called when the region displayed by the map view is about to change
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        print(#function)
    }
    
    // Called when the annotation was added
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("Inside the mapview")
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        print("Till here")
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.animatesDrop = true
            pinView?.canShowCallout = true
            pinView?.isDraggable = true
            pinView?.pinColor = .purple
            
            let rightButton: AnyObject! = UIButton(type: UIButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = rightButton as? UIView
        }
        else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print(#function)
        if control == view.rightCalloutAccessoryView {
            performSegue(withIdentifier: "toTheMoon", sender: self)
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        print("Inside the segue functions")
        if newState == MKAnnotationViewDragState.ending {
            let droppedAt = view.annotation?.coordinate
            print(droppedAt)
        }
    }
    
    // MARK: - Navigation
    
    @IBAction func didReturnToMapViewController(_ segue: UIStoryboardSegue) {
        print(#function)
    }
}

