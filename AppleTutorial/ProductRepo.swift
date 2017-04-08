//
//  ProductRepo.swift
//  AppleTutorial
//
//  Created by Min thu Kyaw on 4/5/17.
//  Copyright © 2017 Min thu Kyaw. All rights reserved.
//

import Foundation
import Alamofire

public class ProductRepo {
    
    class func fetchAllData()
    {
        
        Alamofire.request("http://192.241.250.106:9000/get").responseJSON { response in
            print(response.request ?? "request")  // original URL request
            print(response.response ?? "response") // HTTP URL response
            print(response.data ?? "data")     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
    
}
