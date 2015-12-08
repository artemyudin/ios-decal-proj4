//
//  PersonDetailViewController.swift
//  Elify
//
//  Created by Artem Yudin on 12/6/15.
//  Copyright © 2015 Artem Yudin. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {
    
    var person: Person!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let viewWhite = UIScrollView()
        viewWhite.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height*2)
        viewWhite.backgroundColor = UIColor.whiteColor()
        view.addSubview(viewWhite)
        var cumHeight = 70
        let name = self.person.first + " " + self.person.last
        let textFrame = CGRect(x: 5, y: cumHeight, width: name.characters.count*13, height: 28)
        cumHeight += 34
        let nameLabel = UILabel(frame: textFrame)
        nameLabel.textColor = UIColor.blueColor()
        nameLabel.font = UIFont(name: "Helvetica Neue", size: 24)
        nameLabel.textAlignment = .Left
        nameLabel.text = name
        view.addSubview(nameLabel)
        let textFrame2 = CGRect(x: 5 + name.characters.count*13, y: 78, width: (person.location.characters.count + 3)*7, height: 18)
        let locationLabel = UILabel(frame: textFrame2)
        locationLabel.textColor = UIColor.grayColor()
        locationLabel.font = UIFont(name: "Helvetica Neue", size: 13)
        locationLabel.textAlignment = .Left
        locationLabel.text = "at " + person.location
        view.addSubview(locationLabel)
        
        let image = UIImage(named: "person.png")
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: screenSize.width - 160, y: 100, width: 140, height: 140)
        view.addSubview(imageView)
        
        var interests = "Interests:"
        if let intererstsOriginal = person.interests {
            for elem in intererstsOriginal {
                interests = interests + " " + elem.capitalizedString + ","
            }
            interests = interests.substringToIndex(interests.endIndex.predecessor())
        }
        let textFrame3 = CGRect(x: 5, y: cumHeight, width: Int(screenSize.width) - 10, height: 20)
        cumHeight += 20
        let interestsLabel = UILabel(frame: textFrame3)
        interestsLabel.textColor = UIColor.blackColor()
        interestsLabel.font = UIFont(name: "Helvetica Neue", size: 16)
        interestsLabel.textAlignment = .Left
        interestsLabel.text = interests
        view.addSubview(interestsLabel)
        var groups = "Groups:"
        if let groupsOriginal = person.groups {
            for elem in groupsOriginal {
                groups = groups + " " + elem.capitalizedString + ","
            }
            groups = groups.substringToIndex(groups.endIndex.predecessor())
        }
        let textFrame4 = CGRect(x: 5, y: cumHeight, width: Int(screenSize.width) - 10, height: 20)
        cumHeight += 30
        let groupLabel = UILabel(frame: textFrame4)
        groupLabel.textColor = UIColor.blackColor()
        groupLabel.font = UIFont(name: "Helvetica Neue", size: 16)
        groupLabel.textAlignment = .Left
        groupLabel.text = groups
        view.addSubview(groupLabel)
        
        if let dates = person.dates {
            var dateStr = "Key Moments:\n"
            var count = 1
            for (key, value) in dates {
                dateStr = dateStr + key.capitalizedString + ": " + (value as! String) + "\n"
                count++
            }
            dateStr = dateStr.substringToIndex(dateStr.endIndex.predecessor())
            let textFramedates = CGRect(x: 5, y: cumHeight, width: Int(screenSize.width) - 10, height: 20*count)
            cumHeight += 20*count
            let dateLabel = UILabel(frame: textFramedates)
            dateLabel.textColor = UIColor.blackColor()
            dateLabel.numberOfLines = count
            dateLabel.font = UIFont(name: "Helvetica Neue", size: 14)
            dateLabel.textAlignment = .Left
            dateLabel.text = dateStr
            view.addSubview(dateLabel)
        }
        
        if let phone = person.phone {
            var phoneStr = "Numbers:\n"
            var count = 1
            for (key, value) in phone {
                phoneStr = phoneStr + key.capitalizedString + ": " + (value as! String) + "\n"
                count++
            }
            phoneStr = phoneStr.substringToIndex(phoneStr.endIndex.predecessor())
            let textFrame5 = CGRect(x: 5, y: cumHeight, width: Int(screenSize.width) - 10, height: 20*count)
            cumHeight += 20*count
            let phoneLabel = UILabel(frame: textFrame5)
            phoneLabel.textColor = UIColor.blackColor()
            phoneLabel.numberOfLines = count
            phoneLabel.font = UIFont(name: "Helvetica Neue", size: 14)
            phoneLabel.textAlignment = .Left
            phoneLabel.text = phoneStr
            view.addSubview(phoneLabel)
        }
        if let email = person.emails {
            var emailStr = "Emails:\n"
            var count = 1
            for (key, value) in email {
                emailStr = emailStr + key.capitalizedString + ": " + (value as! String) + "\n"
                count++
            }
            emailStr = emailStr.substringToIndex(emailStr.endIndex.predecessor())
            let textFrame6 = CGRect(x: 5, y: cumHeight, width: Int(screenSize.width) - 10, height: 20*count)
            cumHeight += 20*count
            let emailLabel = UILabel(frame: textFrame6)
            emailLabel.textColor = UIColor.blackColor()
            emailLabel.numberOfLines = count
            emailLabel.font = UIFont(name: "Helvetica Neue", size: 14)
            emailLabel.textAlignment = .Left
            emailLabel.text = emailStr
            view.addSubview(emailLabel)
        }
        if let links = person.links {
            var linkStr = "Links:\n"
            var count = 1
            for (key, value) in links {
                linkStr = linkStr + key.capitalizedString + ": " + (value as! String) + "\n"
                count++
            }
            linkStr = linkStr.substringToIndex(linkStr.endIndex.predecessor())
            let textFrame7 = CGRect(x: 5, y: cumHeight, width: Int(screenSize.width) - 10, height: 20*count)
            cumHeight += 20*count
            let linkLabel = UILabel(frame: textFrame7)
            linkLabel.textColor = UIColor.blackColor()
            linkLabel.numberOfLines = count
            linkLabel.font = UIFont(name: "Helvetica Neue", size: 14)
            linkLabel.textAlignment = .Left
            linkLabel.text = linkStr
            view.addSubview(linkLabel)
        }
        
        let textFrame10 = CGRect(x: 5, y: cumHeight, width: Int(screenSize.width) - 10, height: 20)
        let interactionsLabel = UILabel(frame: textFrame10)
        interactionsLabel.textColor = UIColor.greenColor()
        interactionsLabel.font = UIFont(name: "Helvetica Neue", size: 15)
        interactionsLabel.textAlignment = .Center
        interactionsLabel.text = "Moments/Interactions:"
        view.addSubview(interactionsLabel)
        
        cumHeight += 50
        let textFrame11 = CGRect(x: 5, y: cumHeight, width: Int(screenSize.width) - 10, height: 26)
        let addInteractionButton = UIButton(frame: textFrame11)
        addInteractionButton.setTitle("Add Interaction", forState: .Normal)
        addInteractionButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        addInteractionButton.setTitleColor(UIColor.greenColor(), forState: .Highlighted)
        //addInteractionButton.addTarget(self, action: "addDate:", forControlEvents: .TouchUpInside)
        view.addSubview(addInteractionButton)
        
    }
}
