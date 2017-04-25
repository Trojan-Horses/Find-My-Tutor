//
//  ChattViewController.swift
//  Find my Tutor
//
//  Created by Sumit Dhungel on 4/25/17.
//  Copyright © 2017 Sudheesh Bhattarai. All rights reserved.
//

import UIKit

class ChattViewController: UIViewController {

    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var chatmessage: UILabel!
    
    @IBOutlet weak var tutor: UILabel!
    @IBOutlet weak var tmessage: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tutor.text = "Swapnil"
        tmessage.text = "Hey, I saw your request. Do you need tutoring?"
        name.isHidden = true
        chatmessage.isHidden = true


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chatPressed(_ sender: UIButton) {
        name.isHidden = false
        name.text = "Sumit"
        chatmessage.isHidden = false
        chatmessage.text = message.text

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
