//
//  CloseViewController.swift
//  Find my Tutor
//
//  Created by Sumit Dhungel on 4/25/17.
//  Copyright © 2017 Sudheesh Bhattarai. All rights reserved.
//

import UIKit
import Cosmos

class CloseViewController: UIViewController {
    
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
        @IBAction func closeButton(_ sender: Any) {
        //dismiss(animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameLabel.text = "Swapnil Tamrakar"
        phoneLabel.text = "1234567890"
        emailLabel.text = "swapniltamrakar@hotmail.com"
        cosmosView.settings.updateOnTouch = false

    }

    @IBAction func onClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
