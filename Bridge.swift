//
//  Bridge.swift
//  Firebase2018POC
//
//  Created by Sanad  on 2/27/18.
//  Copyright © 2018 Sanad . All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase
class Bridge {
    static var instance: Bridge!
    
    class func sharedInstance() -> Bridge {
        self.instance = (self.instance ?? Bridge())
        return self.instance
    }
    
    
    
    
    
    
    
}
