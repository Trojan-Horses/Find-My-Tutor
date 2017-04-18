//
//  MapViewController.swift
//  Find my Tutor
//
//  Created by Sudheesh Bhattarai on 3/24/17.
//  Copyright © 2017 Sudheesh Bhattarai. All rights reserved.
//

import UIKit
import MapKit
import Parse
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    var tutorLocation : [(PFObject)]!
    var location: [String]!
    var locationIndex: Int!
    

    @IBOutlet weak var mapView: MKMapView!
    let manager = CLLocationManager()
    var count: Int?
    static var longitude : String?
    static var latitude : String?
    var allElements = [PFObject]()
    var objectID: String!
    
    func getAllData(){
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.includeKey("_id")
        query.includeKey("firstName")
        query.includeKey("phoneNumber")
        query.includeKey("email")
        query.includeKey("occupation")
        query.includeKey("latitude")
        query.includeKey("longitude")
        
        query.includeKey("lastName")
        query.includeKey("author")
        
      

        
        
       query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
        if let random = posts{
            
                self.allElements = random
                var currentUser = PFUser.current()
            
            
                var occupation = currentUser?["occupation"]
                var userName = "\(currentUser?["username"])"
            
            
                for element in self.allElements{
                    if "\(element["author"])" == userName{
                        self.objectID = element.objectId
                    }
                }
            
            
                print("The object id for : ", userName, " is : ", self.objectID)
            
            
            
            
                if occupation as! String != "Tutor"{
                    self.getData(allElement: self.allElements)
                }
                else{
                    self.updateCoordinates()
            }
            
            }
        }
        
    }
    
    func updateCoordinates(){
        
        print("Inside this function")
        print("the id is : ", self.objectID)
        if self.objectID != nil{
            let query = PFQuery(className: "Post")
            do {
                let object = try query.getObjectWithId(self.objectID)
                print("The id is found")
                print("Lat is : ", MapViewController.latitude, "Long is : ",MapViewController.longitude)
                if MapViewController.latitude != nil && MapViewController.longitude != nil{
                    object["latitude"] = MapViewController.latitude
                    object["longitude"] = MapViewController.longitude
                    object.saveInBackground()
                    
                }
            } catch {
                print("Error while saving the data : ",error.localizedDescription)
            }
        }
        // If need for asynch. call uncomment this part
        /*
            query.getObjectInBackground(withId: self.objectID) { (objects, error) -> Void in
                print("Id is found")
                print("Lat is : ", MapViewController.latitude, "Long is : ", MapViewController.longitude)
                if MapViewController.latitude != nil && MapViewController.longitude != nil{
                    objects?["latitude"] = MapViewController.latitude
                    objects?["longitude"] = MapViewController.longitude
//                    objects?.saveInBackground()
//                    print("saved")
//                    print("Lat changed is : ", objects?["latitude"], "Long changed is : ", objects?["longitude"])
                    objects?.saveInBackground { (saved:Bool, error:Error?) -> Void in
                        if saved {
                            print("saved worked")
                            print("Lat changed is : ", objects?["latitude"], "Long changed is : ", objects?["longitude"])
                        } else {
                            print("ERROR happend", error.debugDescription)
                        }
                    }
                    
                    
                    
                }
                else{
                    print("Error updating the data")
                }
                
            }
    */
            
        
    }
    
    func getData(allElement: [PFObject]){
        // construct PFQuery
        locationIndex = 0
        
            for element in self.allElements{
                if element["occupation"] as! String! == "Tutor"{
                        
                        
                    print("The user info is : ", element)
                    var author: String!
                    var longititude: String!
                    var latitude: String!
                        
                    var fullName : String!
                    fullName = element["firstName"] as! String
                    fullName.append(" ")
                    fullName.append(element["lastName"] as! String)
                    
                    author = element["author"] as! String
                    
                    
                    
                    
                    longititude = element["longitude"] as? String
                    latitude = element["latitude"] as? String
                    
                    if longititude != nil && latitude != nil {
                        self.getMarkers(latitude: latitude, longitude: longititude, author: fullName)
                    }
                        
                        
                        

                }
        }
    }
    
    
    //called everytime the user location is changed
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0] //all location are stored in this array, we get the recent location
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        MapViewController.longitude = "\(myLocation.longitude)"
        MapViewController.latitude = "\(myLocation.latitude)"
        
        
        
        if count == 0{
            print("Student? ", LoginViewController.currentUserDetail as String!)
    
            
            
            if(LoginViewController.currentUserDetail as String! == "Student"){
                count = count! + 1
                print("Inside this function")
                Student.postUserImage( withCompletion: { _ in
                    //s MBProgressHUD.showAdded(to: self.view, animated: true)
                    print("Completed")
                    DispatchQueue.main.async {
                        print("POSTED")
                        
                    }}
                )
            }
            else if(LoginViewController.currentUserDetail as String! == "Tutor"){
                count = count! + 1
               
                
                ShareViewController.latitude = MapViewController.latitude!
                ShareViewController.longitude = MapViewController.longitude!
                
            }
            
            
            
        }
        
        //set the region
        let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span) //location and the span
        
        //set the map
        mapView.setRegion(region, animated: true)
        
        //add the blue dot
        self.mapView.showsUserLocation = true
 
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error", error.localizedDescription)
    }
    
    
    func getMarkers(latitude: String, longitude: String, author: String) -> Void {
        
        var lat: Double!
        var lon: Double!
        
         var annotation = MKPointAnnotation()
        var numberFormatter = NumberFormatter()
        var number = numberFormatter.number(from: latitude)
        
                
        lat = number?.doubleValue
        
        number = numberFormatter.number(from: longitude)
        
        lon = number?.doubleValue
        
        print("Latitude is : ", lat, "longitude is : ", lon)
        
        var location = CLLocationCoordinate2DMake(lon, lat)
        
        var span = MKCoordinateSpanMake(0.01, 0.01)
                
                
                
        var region = MKCoordinateRegion(center: location, span: span)
        
         mapView.setRegion(region, animated: true)
        
         annotation.coordinate = location
        
      
        
                
         annotation.title = author
        
        mapView.addAnnotation(annotation)

                
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        getAllData()
        
        print("Inside the student thing")
        
        count = 0
        if LoginViewController.currentUserDetail as String! == "Tutor"{
            manager.desiredAccuracy = kCLLocationAccuracyBest //get best accuracy
            manager.requestWhenInUseAuthorization() //asking user's location in background
            manager.startUpdatingLocation() //called when location is changed

        }
        else{
            //getData()
            //getMarkers()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
