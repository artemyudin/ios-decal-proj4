//
//  PersonTableViewCell.swift
//  Elify
//
//  Created by Artem Yudin on 12/6/15.
//  Copyright © 2015 Artem Yudin. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    let padding: CGFloat = 5
    var background: UIView!
    var locationLabel: UILabel!
    var nameLabel: UILabel!
    
    var person: Person?
    
    func render() {
        if (person?.ready)! {
            nameLabel.text = (person?.last)! + ", " + (person?.first)!
            locationLabel.text = (person?.location) ?? ""
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clearColor()
        selectionStyle = .None
        
        background = UIView(frame: CGRectZero)
        background.alpha = 0.07
        background.backgroundColor = UIColor.blueColor()
        contentView.addSubview(background)
        
        nameLabel = UILabel(frame: CGRectZero)
        nameLabel.textAlignment = .Left
        nameLabel.textColor = UIColor.blackColor()
        contentView.addSubview(nameLabel)
        
        locationLabel = UILabel(frame: CGRectZero)
        locationLabel.textAlignment = .Left
        locationLabel.font = UIFont(name: "Helvetica", size: 11)
        locationLabel.textColor = UIColor.grayColor()
        contentView.addSubview(locationLabel)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        background.frame = CGRectMake(0, 0, frame.width, frame.height)
        nameLabel.frame = CGRectMake(padding*3, 0, frame.width - 10, frame.height-5)
        locationLabel.frame = CGRectMake(padding*3.5, (frame.height - 20), 100, 25)
    }
    
}
