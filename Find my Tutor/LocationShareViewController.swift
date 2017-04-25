//
//  LocationShareViewController.swift
//  Find my Tutor
//
//  Created by Rajjwal Rawal on 4/24/17.
//  Copyright © 2017 Sudheesh Bhattarai. All rights reserved.
//

import UIKit

class LocationShareViewController: UIViewController {

    var val = 0
    
    @IBOutlet weak var buttonClicked: UIImageView!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var studentButton: UIButton!
    @IBAction func locationButton(_ sender: Any) {
        if val == 0 {
            self.performSegue(withIdentifier: "Student", sender: nil)
        } else {
            self.performSegue(withIdentifier: "tutor", sender: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print (val)
        
        if val == 0 {
            
            studentButton.setTitle("Find Nearby Tutors", for: .normal)
            statusButton.isHidden = true
//            self.performSegue(withIdentifier: "Student", sender: nil)
            
        } else {
            statusButton.setTitle("Share My Location", for: .normal)
            studentButton.isHidden = true
//            self.performSegue(withIdentifier: "tutor", sender: nil)
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
