//
//  PeopleVIewController.swift
//  Elify
//
//  Created by Artem Yudin on 12/5/15.
//  Copyright © 2015 Artem Yudin. All rights reserved.
//

import UIKit

class PeopleViewController: UITableViewController {
    
    
    var token: String!
    var email: String!
    var pass: String!
    var people: [Person] = []
    var peopleTableView: UITableView!
    var oldCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPeople()
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        peopleTableView = UITableView()
        peopleTableView.delegate = self
        peopleTableView.dataSource = self
        peopleTableView.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
        //peopleTableView.estimatedRowHeight = 40
        peopleTableView.registerClass(PersonTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(peopleTableView)
    }
    
    func personAdded() {
        reLogin()
        oldCount = people.count
        getPeople()
    }
    
    func check(newCount: Int) {
        if oldCount >= newCount && oldCount != 0 {
            print("fetching again")
            getPeople()
        } else {
            peopleTableView.reloadData()
        }
    }
    
    func getPeople() {
        let request = NSMutableURLRequest(URL: NSURL(string: "http://elify.co:3001/api/people?rand=" + NSUUID().UUIDString)!)
        request.cachePolicy = .ReloadIgnoringLocalAndRemoteCacheData
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        request.addValue(self.token, forHTTPHeaderField: "x-access-token")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let json = try? NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSArray
            
            if(error != nil) {
                print(error!.localizedDescription)
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
            }
            else {
                if let parseJSON = json {
                    self.addPeople(parseJSON!)
                }
                else {
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("Error could not parse JSON: \(jsonStr)")
                }
            }
        })
        
        task.resume()
    }
    
    func addPeople(data: NSArray) {
        people = []
        var count = 0
        for obj : AnyObject in data {
            if let person = obj as? NSDictionary {
                self.people.append(Person(data: person))
                count++
            }
        }
        print("Successfully added \(count) people")
        check(count)
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let toReturn = self.people.count ?? 0
        return toReturn
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")! as! PersonTableViewCell
        cell.person = self.people[indexPath.row]
        cell.render()
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let next = PersonDetailViewController()
        next.person = self.people[indexPath.row]
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let next = segue.destinationViewController as! AddPersonViewController
        next.token = self.token
    }
    
    
    func reLogin() {
        let request = NSMutableURLRequest(URL: NSURL(string: "http://elify.co:3001/api/authenticate")!)
        request.cachePolicy = .ReloadIgnoringLocalAndRemoteCacheData
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        let params = ["email": self.email, "password": self.pass] as Dictionary<String, String>
        
        request.HTTPBody = try? NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions(rawValue: 0))
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let json = try? NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
            
            if(error != nil) {
                print(error!.localizedDescription)
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
                return
            } else {
                if let parseJSON = json {
                    let status = parseJSON!["success"] as! Bool
                    if status {
                        let success = parseJSON!["token"] as! String
                        self.token = success
                    } else {
                        return
                    }
                    
                } else {
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("Error could not parse JSON: \(jsonStr)")
                }
            }
        })
        
        task.resume()
    }


}
