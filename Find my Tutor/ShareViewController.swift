//
//  ShareViewController.swift
//  Find my Tutor
//
//  Created by Sudheesh Bhattarai on 4/4/17.
//  Copyright © 2017 Sudheesh Bhattarai. All rights reserved.
//

import UIKit
import Parse

class ShareViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    static var FirstName: String!
    static var LastName: String!
    static var PhoneNumber: String!
    static var email: String!
    static var occupation: String!
    static var userName: String!
    static var history = Dictionary<String, String>()
    static var latitude: String!
    static var longitude: String!
    

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    static var currentUserDetail: String?
    var userNameTemp: String?

    
    @IBOutlet weak var passWordTextField: UITextField!
    
    @IBOutlet weak var jobPickerView: UIPickerView!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    var choiceIndex = 0
    
    var choices = ["Student","Tutor"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jobPickerView.delegate = self
        jobPickerView.dataSource = self

        // Do any additional setup after loading the view.
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
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choiceIndex = row
        print("Inside the function, the choiceIndex is : ", choiceIndex)
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        var checkSpecialCharacter = false
        let newUser = PFUser()
        var temp = userNameTextField.text
        
        if choiceIndex == 0{
            print("The user will be a student")
            
            var checker = userNameTextField.text!
            if checker.characters.count == 0{
                let alertController = UIAlertController(title: "ERROR!", message: "Username can't be empty", preferredStyle: .alert)
                
                
                let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                    
                }
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            }
            else{
                LoginViewController.currentUserDetail = "Student"
                userNameTemp = "student_" + userNameTextField.text!

            }
            
        }
        else{
            print("The user will be a tutor")
            var checker = userNameTextField.text!
            if checker.characters.count == 0{
                let alertController = UIAlertController(title: "ERROR!", message: "Username can't be empty", preferredStyle: .alert)
                
                
                let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                    
                }
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            }
            else{
                LoginViewController.currentUserDetail = "Tutor"
                userNameTemp = "tutor_" + userNameTextField.text!
            }
           
            
        }
        if userNameTextField.text?.characters.count != 0  && passWordTextField.text?.characters.count != 0{
            
            for characters in (temp?.characters)!{
                if characters == "_"{
                    checkSpecialCharacter = true
                    let alertController = UIAlertController(title: "ERROR!", message: "Cannot include _ in username ", preferredStyle: .alert)
                    
                    
                    let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                        
                    }
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true) {
                        self.userNameTextField.text = ""
                        checkSpecialCharacter =  false
                        // optional code for what happens after the alert controller has finished presenting
                    }

                }
                
                
            }
            print("Check speial character is : ", checkSpecialCharacter)
            print("User name is : ", userNameTemp)
            
            if !checkSpecialCharacter{
                newUser.username = userNameTemp
                newUser.password = passWordTextField.text
                newUser.email = emailTextField.text
                newUser["firstName"] = firstNameTextField.text
                newUser["lastName"] = lastNameTextField.text
                newUser["phoneNumber"] = phoneNumberTextField.text
                
                var tempDict = Dictionary<String, String> ()
                
                ShareViewController.history = tempDict
                ShareViewController.userName = userNameTextField.text
                ShareViewController.FirstName = firstNameTextField.text
                ShareViewController.LastName = lastNameTextField.text
                ShareViewController.PhoneNumber = phoneNumberTextField.text
                ShareViewController.email = emailTextField.text
                ShareViewController.latitude = ""
                ShareViewController.longitude = ""
                
                if choiceIndex == 0{
                    newUser["occupation"] = "Student"
                    ShareViewController.occupation = "Student"
                }
                else{
                    newUser["occupation"] = "Tutor"
                        ShareViewController.occupation = "Tutor"
                }
                
                newUser.signUpInBackground {
                    (succeeded: Bool, error:Error?) -> Void in
                    if succeeded {
                        print("Created a", LoginViewController.currentUserDetail!, " user")
                        
                        
                        let alertController = UIAlertController(title: "WELCOME", message: "Welcome to Chat", preferredStyle: .alert)
                        
                        
                        let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                            
                        }
                        alertController.addAction(cancelAction)
                        
                        
                        self.present(alertController, animated: true) {
                            Tutor.postUserImage( withCompletion: { _ in
                                //s MBProgressHUD.showAdded(to: self.view, animated: true)
                                print("Completed")
                                DispatchQueue.main.async {
                                    print("POSTED")
                                    
                                }}
                            )

                            // optional code for what happens after the alert controller has finished presenting
                            self.performSegue(withIdentifier: "loginSignUpSegue", sender: nil)
                            //self.dismiss(animated: true, completion: nil)
                        }
                        //loginSignUpSegue
                        
                        
                    }
                    else{
                        print("Error is : ",error?.localizedDescription)
                    }
                    
                }
                
                
            }
            
            

        }
        else{
            
            let alertController = UIAlertController(title: "ERROR!", message: "Username or password can't be empty", preferredStyle: .alert)
            
            
            let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                
            }
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
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
