//
//  colormind.swift
//  colormind-test
//
//  Created by Rudolf Paduraru on 02/08/2020.
//  Copyright © 2020 Rudolf Paduraru. All rights reserved.
//

import Foundation

class ColormindAPI {

    
    class func requestColor(){
        let parameters = ["model": "default"] as [String : Any]
            //create the url with URL
            let url = URL(string: "http://colormind.io/api/")!

            //create the session object
            let session = URLSession.shared
            //now create the URLRequest object using the url object
            var request = URLRequest(url: url)
            request.httpMethod = "POST" //set http method as POST

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            } catch let error {
                print(error.localizedDescription)
            }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")

            //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler:  { data, response, error -> Void in

                guard error == nil else {
                    return
                }
                guard let data = data else {
                    return
                }
                do{
                    //create json object from data
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
//                        print(json)
                        if let colors = json["result"] as? [Array<Double>]{
                            let myColors = colors[0]
                            Rgb.rgb.red = myColors[0]
                            Rgb.rgb.green = myColors[1]
                            Rgb.rgb.blue = myColors[2]
                            Rgb.status = true
                        }
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            })
            task.resume()
        
        }
    
    
    
}

