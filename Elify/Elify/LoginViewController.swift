//
//  ViewController.swift
//  Elify
//
//  Created by Artem Yudin on 12/5/15.
//  Copyright © 2015 Artem Yudin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var state: String!
    var token: String!
    var emailS: String!
    var passS: String!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var main: UIButton!
    @IBOutlet weak var next: UIButton!
    @IBOutlet weak var stderr: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        state = "Login"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func switchState() {
        stderr.text = ""
        switch self.state {
        case "Login":
            self.state = "Signup"
            main.setTitle("Sign up!", forState: .Normal)
            next.setTitle("Login instead", forState: .Normal)
            break
        case "Signup":
            self.state = "Login"
            main.setTitle("Login", forState: .Normal)
            next.setTitle("Sign up!", forState: .Normal)
            break
        default:
            break
        }
    }
    @IBAction func processEntry() {
        self.stderr.textColor = UIColor.redColor()
        stderr.text = ""
        let emailData = email.text
        let passData = pass.text
        if emailData == nil || passData == nil || emailData!.isEmpty || passData!.isEmpty {
            displayError("Email and password cannot be empty")
            return
        }
        if !emailData!.containsString("@") || !emailData!.containsString(".") {
            displayError("Please enter a valid email")
            return
        }
        if passData!.characters.count < 6 {
            displayError("Password must be at least 6 characters")
            return
        }
        switch self.state {
        case "Login":
            loginUser(emailData!, pass: passData!)
            break
        case "Signup":
            signupUser(emailData!, pass: passData!)
            break
        default:
            break
        }
    }
    
    func displayError(str: String) {
        stderr.textColor = UIColor.redColor()
        stderr.text = str
    }
    
    func loginUser(email: String, pass: String) {
        self.emailS = email
        self.passS = pass
        stderr.textColor = UIColor.greenColor()
        stderr.text = "Attempting login, please wait"
        print("Login: \(email)")
        let request = NSMutableURLRequest(URL: NSURL(string: "http://elify.co:3001/api/authenticate")!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        let params = ["email": email, "password": pass] as Dictionary<String, String>
        
        request.HTTPBody = try? NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions(rawValue: 0))
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let json = try? NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
            
            if(error != nil) {
                print(error!.localizedDescription)
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    self.displayError("Unexpected Error. Please try again later")
                }
                print("Error could not parse JSON: '\(jsonStr)'")
                return
            } else {
                if let parseJSON = json {
                    let status = parseJSON!["success"] as! Bool
                    if status {
                        let success = parseJSON!["token"] as! String
                        self.token = success
                        NSOperationQueue.mainQueue().addOperationWithBlock {
                            self.performSegueWithIdentifier("login", sender: self)
                        }
                    } else {
                        NSOperationQueue.mainQueue().addOperationWithBlock {
                            self.displayError("Incorrect email and/or password")
                        }
                        return
                    }
                    
                } else {
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    NSOperationQueue.mainQueue().addOperationWithBlock {
                        self.displayError("Unexpected Error. Please try again later")
                    }
                    print("Error could not parse JSON: \(jsonStr)")
                }
            }
        })
        
        task.resume()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            let nav = (segue.destinationViewController as! UINavigationController)
            let next = nav.topViewController as! PeopleViewController
            next.token = self.token
            next.email = self.emailS
            next.pass = self.passS
    }
    
    func signupUser(email: String, pass: String) {
        self.emailS = email
        self.passS = pass
        print("SignUp: \(email)")
        let request = NSMutableURLRequest(URL: NSURL(string: "http://elify.co:3001/api/signup")!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        let params = ["email": email, "password": pass] as Dictionary<String, String>
        
        request.HTTPBody = try? NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions(rawValue: 0))
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let json = try? NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
            
            if(error != nil) {
                print(error!.localizedDescription)
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    self.displayError("Unexpected Error. Please try again later")
                }
                print("Error could not parse JSON: '\(jsonStr)'")
                return
            } else {
                if let _ = json {
                    NSOperationQueue.mainQueue().addOperationWithBlock {
                        self.loginUser(self.emailS, pass: self.passS)
                    }
                    
                } else {
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    NSOperationQueue.mainQueue().addOperationWithBlock {
                        self.displayError("Unexpected Error. Please try again later")
                    }
                    print("Error could not parse JSON: \(jsonStr)")
                }
            }
        })
        
        task.resume()
    }

}

