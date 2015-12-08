//
//  Person.swift
//  Elify
//
//  Created by Artem Yudin on 12/5/15.
//  Copyright © 2015 Artem Yudin. All rights reserved.
//

import Foundation


class Person {
    
    var first: String!
    var last: String!
    var location: String
    var interactions: NSArray
    var reminders: NSArray
    var notes: NSArray
    var ready = false
    
    
    var information: NSArray
    var groups: [String]?
    var interests: [String]?
    var dates: NSDictionary?
    
    var contact: NSDictionary?
    var phone: NSDictionary?
    var links: NSDictionary?
    var emails: NSDictionary?
    
    
    
    
    init (data: NSDictionary) {
        first = data["first"] as! String
        last = data["last"] as! String
        location = data["location"] as! String
        contact = data["contact"] as? NSDictionary
        information = data["information"] as! NSArray
        interactions = data["interactons_id"] as! NSArray
        reminders = data["reminders"] as! NSArray
        notes = data["notes"] as! NSArray

        for obj : AnyObject in information {
            if let info = obj as? NSDictionary {
                let title = info["title"] as! String
                switch title {
                case "Groups":
                    groups = info["list"] as? [String]
                case "Interests":
                    interests = info["list"] as? [String]
                case "Dates":
                    dates = info["pairs"] as? NSDictionary
                default:
                    break
                }
            }
        }
        if let phoneN = contact!["phone"] as? NSDictionary {
            phone = phoneN
        }
        if let link = contact!["link"] as? NSDictionary {
            links = link
        }
        if let email = contact!["email"] as? NSDictionary {
            emails = email
        }
        
        ready = true
        //print("Success: \(last), \(first) lives in \(location), has interactions \(interactions) and reminders \(reminders) and notes \(notes) and gen_info \(information) with contact info: \(contact)")
    }
}