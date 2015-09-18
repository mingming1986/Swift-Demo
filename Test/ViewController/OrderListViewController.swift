//
//  OrderListViewController.swift
//  Test
//
//  Created by Mingming Wang on 9/12/15.
//  Copyright (c) 2015 Mingming Wang. All rights reserved.
//

import UIKit

class OrderListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, JsonReceiverDelegate {
    @IBOutlet var orderTable:UITableView!
    
    var alertView:UIAlertView!
    
    var orderList: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Order List"
        
        WebFetcher.sharedInstance.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    
        self.fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fetchData()
    {
        self.showLoadingDialog()
        
        WebFetcher.sharedInstance.order()
    }
    
    func tableView (tableView : UITableView , cellForRowAtIndexPath indexPath : NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("orderCell", forIndexPath: indexPath) as OrderListCell
        
        if (orderList.count > 0) {
            var dictionary : NSDictionary = orderList.objectAtIndex(indexPath.row) as NSDictionary
            
            cell.setInfo(dictionary)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC = self.storyboard?.instantiateViewControllerWithIdentifier("detailVC") as DetailInfoViewController
        detailVC.dictionary = orderList.objectAtIndex(indexPath.row) as NSDictionary
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

    func receiveJson(jsonDictionary:NSDictionary) {
        self.hideLoadingDialog()
        
        var childrenArray : NSArray = jsonDictionary.objectForKey("objects") as NSArray
        
        var bodyArray: NSMutableArray = NSMutableArray()
        
        for child : AnyObject in childrenArray {
            var dictionary : NSDictionary = child as NSDictionary
            
            bodyArray.addObject(dictionary)
        }
        
        orderList = bodyArray
        
        dispatch_async(dispatch_get_main_queue(),{
            self.orderTable.reloadData()
        });
    }
    
    func showLoadingDialog() {
        alertView = UIAlertView()
        alertView.title = "Loading order list..."
        alertView.show()
    }
    
    func hideLoadingDialog() {
        alertView.dismissWithClickedButtonIndex(0, animated: true)
    }
}
