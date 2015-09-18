//
//  WebFetcher.swift
//  Test
//
//  Created by Mingming Wang on 9/12/15.
//  Copyright (c) 2015 Mingming Wang. All rights reserved.
//

import UIKit

let _sharedInstance = WebFetcher()

class WebFetcher: NSObject {
    let publicKey:NSString = "d3d7ad38-b595-4c4f-826f-5e0ddb556226"
    
    class var sharedInstance : WebFetcher {
        return _sharedInstance
    }
    
    var delegate: JsonReceiverDelegate?
    
    func login(username: NSString, password: NSString) {
        var postEndpoint: NSString = "http://private-anon-4c3fd03d2-hackermantion.apiary-mock.com/api/sessions/"
        var postUrlRequest = NSMutableURLRequest(URL: NSURL(string:postEndpoint)!)
        
        postUrlRequest.HTTPMethod = "POST"
        
        var postParams: NSDictionary = ["email":username, "password":password, "publicKey":publicKey];
        
        var postJSONError:NSError?
        
        var jsonPost = NSJSONSerialization.dataWithJSONObject(postParams, options: nil, error: &postJSONError);
        
        postUrlRequest.HTTPBody = jsonPost
        
        NSURLConnection.sendAsynchronousRequest(postUrlRequest, queue: NSOperationQueue(), completionHandler: {
            (response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
            
            self.receivedJson(data)
        })
    }
    
    func order() {
        var postEndpoint: NSString = "http://private-anon-4c3fd03d2-hackermantion.apiary-mock.com/orders"
        var postUrlRequest = NSMutableURLRequest(URL: NSURL(string:postEndpoint)!)
        
        postUrlRequest.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(postUrlRequest, queue: NSOperationQueue(), completionHandler: {
            (response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
            
            self.receivedJson(data)
        })
    }
    
    func receivedJson(data: NSData) {
        var error: NSErrorPointer = nil
        var jsonDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: error) as NSDictionary
        
        delegate!.receiveJson(jsonDictionary)
    }
}
