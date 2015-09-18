//
//  OrderListCell.swift
//  Test
//
//  Created by Mingming Wang on 9/12/15.
//  Copyright (c) 2015 Mingming Wang. All rights reserved.
//

import UIKit

class OrderListCell: UITableViewCell {
    @IBOutlet var noteLabel:UILabel!
    @IBOutlet var customerLabel:UILabel!
    @IBOutlet var dateLabel:UILabel!
    @IBOutlet var originLabel:UILabel!
    @IBOutlet var destinationLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setInfo(dictionary: NSDictionary) {
        var created : NSString = dictionary.objectForKey("created") as NSString
        
        var addressDict : NSDictionary = dictionary.objectForKey("address") as NSDictionary
        var distDict : NSDictionary = dictionary.objectForKey("destination") as NSDictionary
        
        var coordinateArray: NSArray = addressDict.objectForKey("coordinates") as NSArray
        
        var customerDict : NSDictionary = dictionary.objectForKey("customer") as NSDictionary
        var customerDataDict : NSDictionary = customerDict.objectForKey("data") as NSDictionary
        
        var note : NSString = addressDict.objectForKey("note") as NSString
        var originAddress : NSString = addressDict.objectForKey("text") as NSString
        var distAddress : NSString = distDict.objectForKey("text") as NSString
        var customer : NSString = customerDataDict.objectForKey("name") as NSString
        var type : NSString = addressDict.objectForKey("type") as NSString
        
        noteLabel?.text = note
        customerLabel?.text = customer
        dateLabel?.text = created
        originLabel?.text = originAddress
        destinationLabel?.text = distAddress
    }
}
