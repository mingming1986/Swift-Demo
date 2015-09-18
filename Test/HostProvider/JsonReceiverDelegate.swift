//
//  JsonReceiverDelegate.swift
//  Test
//
//  Created by Mingming Wang on 9/12/15.
//  Copyright (c) 2015 Mingming Wang. All rights reserved.
//

import Foundation

protocol JsonReceiverDelegate {
   func receiveJson(jsonDictionary:NSDictionary) ->()
}
