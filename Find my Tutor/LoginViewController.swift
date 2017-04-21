//
//  LoginViewController.swift
//  Find my Tutor
//
//  Created by Sudheesh Bhattarai on 3/24/17.
//  Copyright © 2017 Sudheesh Bhattarai. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var userNameLabel: UITextField!
    
    @IBOutlet weak var choiceLabel: UIPickerView!
    @IBOutlet weak var passWordLabel: UITextField!
    var choiceIndex = 0
    
    var choices = ["Student","Tutor"]
    
    static var currentUserDetail: String?
    var userNameTemp: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        choiceLabel.delegate = self
        choiceLabel.dataSource = self
        
        


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return choices[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return choices.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    

    @IBAction func onSignUp(_ sender: Any) {
        self.performSegue(withIdentifier: "signUpSegue", sender: nil)
        
        
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choiceIndex = row
        print("The user is picking")
    }
    
    
    
    @IBOutlet weak var tutorSignUp: UIButton!
    
    
    
    
    @IBAction func onSignIn(_ sender: Any) {
        if choiceIndex == 0{
            LoginViewController.currentUserDetail = "Student"
            userNameTemp = "student_" + userNameLabel.text!
        }
        else{
            LoginViewController.currentUserDetail = "Tutor"
            userNameTemp = "tutor_" + userNameLabel.text!
        }
        PFUser.logInWithUsername(inBackground: userNameTemp!, password: passWordLabel.text!){
            user, error in
            if user != nil{
                print("User logined")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else{
               let alertController = UIAlertController(title: "ERROR", message: "Enter a valid username or password ", preferredStyle: .alert)
                
                
                let backView = alertController.view.subviews.last?.subviews.last
                backView?.layer.cornerRadius = 20.0
                backView?.backgroundColor = UIColor.green
                
                // Change Title With Color and Font:
                
                let myString  = "ERROR!!!"
                var myMutableString = NSMutableAttributedString()
                myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 20.0)!])
                myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSRange(location:0,length:myString.characters.count))
                alertController.setValue(myMutableString, forKey: "attributedTitle")
                
                let message  = "                                              Enter a valid Username/Password                                                  "
                var messageMutableString = NSMutableAttributedString()
                messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSFontAttributeName:UIFont(name: "Noteworthy", size: 18.0)!])
                messageMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: NSRange(location:0,length:message.characters.count))
                alertController.setValue(messageMutableString, forKey: "attributedMessage")

            
                
                let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                // add the cancel action to the alertController
                alertController.addAction(cancelAction)
                
             self.present(alertController, animated: true) {
                    //optional code for what happens after the alert controller has finished presenting
              }
                
            }
        }
        
        
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
