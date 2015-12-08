//
//  AddPersonViewController.swift
//  Elify
//
//  Created by Artem Yudin on 12/7/15.
//  Copyright © 2015 Artem Yudin. All rights reserved.
//

import UIKit

class AddPersonViewController: UIViewController, UITextFieldDelegate {
    
    var scrollView: UIScrollView!
    var firstTF: UITextField!
    var lastTF: UITextField!
    var locationTF: UITextField!
    var phoneTF: UITextField!
    var emailTF: UITextField!
    var linkTF: UITextField!
    var groupsTF: UITextField!
    var interestsTF: UITextField!
    var dateTF: UITextField!
    var datePicker: UIDatePicker!
    var dates = [String]()
    
    var token: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.whiteColor()
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height*1.23)
        scrollView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        view.addSubview(scrollView)

        var cumHeight = 12
        var tfFrame = CGRect(x: 10, y: cumHeight, width: Int(view.bounds.width) - 20, height: 14)
        let basicInfoLabel = UILabel(frame: tfFrame)
        basicInfoLabel.textColor = UIColor.orangeColor()
        basicInfoLabel.font = UIFont(name: "Helvetica Neue", size: 16)
        basicInfoLabel.textAlignment = .Left
        basicInfoLabel.text = "Basic Info"
        scrollView.addSubview(basicInfoLabel)
        
        
        
        cumHeight += 16
        tfFrame = CGRect(x: 10, y: cumHeight, width: Int(view.bounds.width) - 20, height: 26)
        self.firstTF = UITextField(frame: tfFrame)
        self.firstTF.placeholder = "First (ex. Alex)"
        self.firstTF.font = .systemFontOfSize(15)
        self.firstTF.borderStyle = .RoundedRect
        self.firstTF.autocorrectionType = .No
        self.firstTF.keyboardType = .Default
        self.firstTF.returnKeyType = .Default
        self.firstTF.clearButtonMode = .Never;
        self.firstTF.contentVerticalAlignment = .Center
        self.firstTF.delegate = self
        self.scrollView.addSubview(self.firstTF)
        
        cumHeight += 35
        tfFrame = CGRect(x: 10, y: cumHeight, width: Int(view.bounds.width) - 20, height: 26)
        self.lastTF = UITextField(frame: tfFrame)
        self.lastTF.placeholder = "Last (ex. Smith)"
        self.lastTF.font = .systemFontOfSize(15)
        self.lastTF.borderStyle = .RoundedRect
        self.lastTF.autocorrectionType = .No
        self.lastTF.keyboardType = .Default
        self.lastTF.returnKeyType = .Default
        self.lastTF.clearButtonMode = .Never;
        self.lastTF.contentVerticalAlignment = .Center
        self.lastTF.delegate = self
        self.scrollView.addSubview(self.lastTF)
        
        cumHeight += 35
        tfFrame = CGRect(x: 10, y: cumHeight, width: Int(view.bounds.width) - 20, height: 26)
        self.locationTF = UITextField(frame: tfFrame)
        self.locationTF.placeholder = "Location (ex. New York)"
        self.locationTF.font = .systemFontOfSize(15)
        self.locationTF.borderStyle = .RoundedRect
        self.locationTF.autocorrectionType = .No
        self.locationTF.keyboardType = .Default
        self.locationTF.returnKeyType = .Default
        self.locationTF.clearButtonMode = .Never;
        self.locationTF.contentVerticalAlignment = .Center
        self.locationTF.delegate = self
        self.scrollView.addSubview(self.locationTF)
        
        cumHeight += 45
        tfFrame = CGRect(x: 10, y: cumHeight, width: Int(view.bounds.width) - 20, height: 14)
        let contactInfoLabel = UILabel(frame: tfFrame)
        contactInfoLabel.textColor = UIColor.orangeColor()
        contactInfoLabel.font = UIFont(name: "Helvetica Neue", size: 16)
        contactInfoLabel.textAlignment = .Left
        contactInfoLabel.text = "Contact Info"
        scrollView.addSubview(contactInfoLabel)
        
        cumHeight += 16
        tfFrame = CGRect(x: 10, y: cumHeight, width: Int(view.bounds.width) - 20, height: 26)
        self.phoneTF = UITextField(frame: tfFrame)
        self.phoneTF.placeholder = "Phone (cell: 510-646-5999, work: 415-123-4567)"
        self.phoneTF.font = .systemFontOfSize(14)
        self.phoneTF.borderStyle = .RoundedRect
        self.phoneTF.autocorrectionType = .No
        self.phoneTF.keyboardType = .Default
        self.phoneTF.returnKeyType = .Default
        self.phoneTF.clearButtonMode = .Never;
        self.phoneTF.contentVerticalAlignment = .Center
        self.phoneTF.delegate = self
        self.scrollView.addSubview(self.phoneTF)
        
        cumHeight += 35
        tfFrame = CGRect(x: 10, y: cumHeight, width: Int(view.bounds.width) - 20, height: 26)
        self.emailTF = UITextField(frame: tfFrame)
        self.emailTF.placeholder = "Email (main: me@gmail.com, work: art@elify.co)"
        self.emailTF.font = .systemFontOfSize(15)
        self.emailTF.borderStyle = .RoundedRect
        self.emailTF.autocorrectionType = .No
        self.emailTF.keyboardType = .Default
        self.emailTF.returnKeyType = .Default
        self.emailTF.clearButtonMode = .Never;
        self.emailTF.contentVerticalAlignment = .Center
        self.emailTF.delegate = self
        self.scrollView.addSubview(self.emailTF)
        
        cumHeight += 35
        tfFrame = CGRect(x: 10, y: cumHeight, width: Int(view.bounds.width) - 20, height: 26)
        self.linkTF = UITextField(frame: tfFrame)
        self.linkTF.placeholder = "Links (wiki: smirnov.wiki, personal: arj.com)"
        self.linkTF.font = .systemFontOfSize(15)
        self.linkTF.borderStyle = .RoundedRect
        self.linkTF.autocorrectionType = .No
        self.linkTF.keyboardType = .Default
        self.linkTF.returnKeyType = .Default
        self.linkTF.clearButtonMode = .Never;
        self.linkTF.contentVerticalAlignment = .Center
        self.linkTF.delegate = self
        self.scrollView.addSubview(self.linkTF)
        
        cumHeight += 45
        tfFrame = CGRect(x: 10, y: cumHeight, width: Int(view.bounds.width) - 20, height: 14)
        let otherInfoLabel = UILabel(frame: tfFrame)
        otherInfoLabel.textColor = UIColor.orangeColor()
        otherInfoLabel.font = UIFont(name: "Helvetica Neue", size: 16)
        otherInfoLabel.textAlignment = .Left
        otherInfoLabel.text = "Other Info"
        scrollView.addSubview(otherInfoLabel)
        
        cumHeight += 16
        tfFrame = CGRect(x: 10, y: cumHeight, width: Int(view.bounds.width) - 20, height: 26)
        self.interestsTF = UITextField(frame: tfFrame)
        self.interestsTF.placeholder = "Interests (ex. Skiing, Skydiving)"
        self.interestsTF.font = .systemFontOfSize(15)
        self.interestsTF.borderStyle = .RoundedRect
        self.interestsTF.autocorrectionType = .No
        self.interestsTF.keyboardType = .Default
        self.interestsTF.returnKeyType = .Default
        self.interestsTF.clearButtonMode = .Never;
        self.interestsTF.contentVerticalAlignment = .Center
        self.interestsTF.delegate = self
        self.scrollView.addSubview(self.interestsTF)
        
        cumHeight += 35
        tfFrame = CGRect(x: 10, y: cumHeight, width: Int(view.bounds.width) - 20, height: 26)
        self.groupsTF = UITextField(frame: tfFrame)
        self.groupsTF.placeholder = "Groups (ex. KKГ, Russians)"
        self.groupsTF.font = .systemFontOfSize(15)
        self.groupsTF.borderStyle = .RoundedRect
        self.groupsTF.autocorrectionType = .No
        self.groupsTF.keyboardType = .Default
        self.groupsTF.returnKeyType = .Default
        self.groupsTF.clearButtonMode = .Never;
        self.groupsTF.contentVerticalAlignment = .Center
        self.groupsTF.delegate = self
        self.scrollView.addSubview(self.groupsTF)
        
        
        cumHeight += 45
        tfFrame = CGRect(x: 10, y: cumHeight, width: Int(view.bounds.width) - 20, height: 14)
        let datesLabel = UILabel(frame: tfFrame)
        datesLabel.textColor = UIColor.orangeColor()
        datesLabel.font = UIFont(name: "Helvetica Neue", size: 16)
        datesLabel.textAlignment = .Left
        datesLabel.text = "Important dates"
        scrollView.addSubview(datesLabel)
        
        cumHeight += 16
        tfFrame = CGRect(x: 10, y: cumHeight, width: Int(view.bounds.width) - 20, height: 26)
        self.dateTF = UITextField(frame: tfFrame)
        self.dateTF.placeholder = "Event (ex. First Met / Birthday)"
        self.dateTF.font = .systemFontOfSize(15)
        self.dateTF.borderStyle = .RoundedRect
        self.dateTF.autocorrectionType = .No
        self.dateTF.keyboardType = .Default
        self.dateTF.returnKeyType = .Default
        self.dateTF.clearButtonMode = .Never;
        self.dateTF.contentVerticalAlignment = .Center
        self.dateTF.delegate = self
        self.scrollView.addSubview(self.dateTF)
        
        cumHeight += 28
        tfFrame = CGRect(x: 10, y: cumHeight, width: Int(view.bounds.width) - 20, height: 140)
        datePicker = UIDatePicker(frame: tfFrame)
        datePicker.datePickerMode = .Date
        scrollView.addSubview(datePicker)
        
        cumHeight += 150
        tfFrame = CGRect(x: 10, y: cumHeight, width: Int(view.bounds.width) - 20, height: 40)
        let addDateButton = UIButton(frame: tfFrame)
        addDateButton.setTitle("Add Another Date", forState: .Normal)
        addDateButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        addDateButton.addTarget(self, action: "addDate:", forControlEvents: .TouchUpInside)
        scrollView.addSubview(addDateButton)
    }
    
    func addDate(sender: AnyObject!) {
        if let name = dateTF.text {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .ShortStyle
            let strDate = dateFormatter.stringFromDate(datePicker.date)
            dates.append("\"\(name)\":\"\(strDate)\"")
            print("Added new date \(strDate) for event \(name)")
            dateTF.text = ""
        }
    }
    
    func splitToDict(data: String?) -> String {
        let pairs = data!.characters.split{$0 == ","}.map(String.init)
        var toReturn = ""
        for elem in pairs {
            let pair = elem.characters.split{$0 == ":"}.map(String.init)
            let key = pair[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            let value = pair[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            toReturn += "\"" + key + "\":\"" + value + "\",\n"
        }
        toReturn = toReturn.substringToIndex(toReturn.endIndex.predecessor())
        toReturn = toReturn.substringToIndex(toReturn.endIndex.predecessor())
        return toReturn
    }
    
    @IBAction func onSave(sender: UIBarButtonItem) {
        print("Saving")
        if let date = dateTF.text {
            if date.characters.count > 0 {
                addDate(self)
            }
        }
        let first = firstTF.text!
        let last = lastTF.text!
        let location = locationTF.text!
        let phone = splitToDict(phoneTF.text)
        let email = splitToDict(emailTF.text)
        let link = splitToDict(linkTF.text)
        var groupsA = groupsTF.text!.characters.split{$0 == ","}.map(String.init)
        var interestsA = interestsTF.text!.characters.split{$0 == ","}.map(String.init)
        let dates = self.dates.joinWithSeparator(",")
        groupsA = groupsA.map {
            (let elem) -> String in
            return "\"" + elem.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) + "\""
        }
        interestsA = interestsA.map {
            (let elem) -> String in
            return "\"" + elem.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) + "\""
        }
        let groups = groupsA.joinWithSeparator(",")
        let interests = interestsA.joinWithSeparator(",")
        
        // create the request & response
        let request = NSMutableURLRequest(URL: NSURL(string: "http://elify.co:3001/api/person")!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        var response: NSURLResponse?
        
        // create some JSON data and configure the request
        var jsonString = "{\"person\" : {\"first\":\"\(first)\",\"last\":\"\(last)\", " +
            "\"location\": \"\(location)\",\"contact\" : {\"email\":{\(email)" +
            "},\"link\":{\(link)},\"phone\":{\(phone)}},\"information\" : [{" +
            "\"title\": \"Dates\",\"pairs\" : {\(dates)}},"
        jsonString +=
            "{\"title\" : \"Groups\",\"list\" : [\(groups)],\"ordered\" : false},{" +
            "\"title\" : \"Interests\",\"list\" : [\(interests)]," +
            "\"ordered\" : false}],\"interactions_id\":[]}}"
        request.HTTPBody = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        request.HTTPMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(self.token, forHTTPHeaderField: "x-access-token")
        
        // send the request
        _ = try? NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
        
        // look at the response
        if let httpResponse = response as? NSHTTPURLResponse {
            print("HTTP response: \(httpResponse.statusCode)")
        } else {
            print("No HTTP response")
        }
        
        if let navigationController = self.navigationController
        {
            let nav = navigationController.viewControllers[navigationController.viewControllers.count-2] as! PeopleViewController
            nav.personAdded()
            navigationController.popViewControllerAnimated(true)
        }
        
    }
    
    @IBAction func onCancel(sender: UIBarButtonItem) {
        navigationController!.popViewControllerAnimated(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
}
