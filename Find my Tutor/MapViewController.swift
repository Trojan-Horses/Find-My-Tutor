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
    
    func getData(){
        // construct PFQuery
        locationIndex = 0
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                self.tutorLocation = posts
                
                for element in self.tutorLocation{
                    if element["student"] as! String! == "Tutor"{
                        
                        var author: String!
                        var longititude: String!
                        var latitude: String!
                        
                        author = element["author"] as! String
                        longititude = element["latitude"] as! String
                        latitude = element["longitutude"] as! String
                        
                        self.getMarkers(latitude: latitude, longitude: longititude, author: author)
                    }
                }
                
                // do something with the data fetched
            } else {
                print("Error! : ", error?.localizedDescription)
                // handle error
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
                print("Inside this function")
                Tutor.postUserImage( withCompletion: { _ in
                    //s MBProgressHUD.showAdded(to: self.view, animated: true)
                    print("Completed")
                    DispatchQueue.main.async {
                        print("POSTED")
                        
                    }}
                )
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
    
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        if LoginViewController.currentUserDetail == "Student"{
//            
//            getData()
//            //print("The post are : ", tutorLocation)
//        }
//        
//        
//    }
    
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
        
//        var start = author.index(author.startIndex, offsetBy: 5)
//        print("The end Index is : ", author.endIndex)
//        var end = author.endIndex
//        
//        var range = start ... end
//        var correctAuthor = author[range]
//
//        print("Author is : ", correctAuthor)
        
        
        var correctAuthor: String!
        var slicingIndex: Int!
        slicingIndex = 0
        correctAuthor = ""
        for element in author.characters{
            print("Chracter outsude is : ", element)
            if slicingIndex >= 6{
                print("Character is : ", element)
                correctAuthor = correctAuthor + String(element)
               
            }
            slicingIndex = slicingIndex + 1
        }
        
         mapView.setRegion(region, animated: true)
        
         annotation.coordinate = location
        
      
        
                
         annotation.title = correctAuthor
        
        mapView.addAnnotation(annotation)

                
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        
        count = 0
        if LoginViewController.currentUserDetail as String! == "Tutor"{
            manager.desiredAccuracy = kCLLocationAccuracyBest //get best accuracy
            manager.requestWhenInUseAuthorization() //asking user's location in background
            manager.startUpdatingLocation() //called when location is changed

        }
        else{
            getData()
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
