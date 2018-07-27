//
//  PhysicistOfTheDayManager.swift
//  Physics Phun
//
//  Created by Omar Al-Ejel on 7/22/18.
//  Copyright © 2018 omaralejel. All rights reserved.
//

import UIKit

/// Responsible for fetching data about an interesting physicist 
class PhysicistOfTheDayManager {
    
    var currentNameIndex = -1
    var names = [
        "Marie Curie",
        "Isaac Newton",
        "Albert Einstein",
        "Richard Feynman",
        "Rosalind Franklin",
        "Erwin Schrödinger",
        "Niels_Bohr",
        "Lise_Meitner",
        "Blaise_Pascal",
        "Max_Planck",
        "Galileo_Galilei",
        "James_Chadwick",
        "Carl_Sagan",
        "Georg_Ohm",
        "Eva_Silverstein",
        "Satyendra_Nath_Bose",
        "Wolfgang_Pauli",
        "Christiaan_Huygens",
        "Louis_de_Broglie"
    ]
    
//    var completionHandler: ((name: String, description: String, ) -> Void)?
    
    static var shared: PhysicistOfTheDayManager = PhysicistOfTheDayManager()
    
    var session: URLSession!
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config, delegate: nil, delegateQueue: nil)
    }
    
    func update(completionHandler: @escaping ((_ name: String, _ description: String, _ url: URL, _ iconImage: UIImage?) -> Void)) {
        // request data related to a physicist
        
        if let url = getNextURL() {
            var request = URLRequest(url: url)
            request.httpMethod = "GET" // should be default setting, but just making this a point
            //        request.timeoutInterval = 10
            let dataTask = session.dataTask(with: request) { (data, response, err) in
                if err != nil {
                    print(err ?? "error_alt")
                }
                
                if let sureData = data {
                    let JSON = (try? JSONSerialization.jsonObject(with: sureData, options: [])) as? NSDictionary
                    if let sureJSON = JSON {
                        self.parseJSON(jsonDict: sureJSON, completion: { (title, desc, image) in
                            // we call the completion handler
                            let webpageURL = URL(string: "https://en.wikipedia.org/wiki/\(self.names[self.currentNameIndex])")!
                            completionHandler(title, desc, webpageURL, image)
                        })
                    }
                }
            }
            
            dataTask.resume()
        } else {
            print("Got nil url")
        }
    }
    
    func parseJSON(jsonDict: NSDictionary, completion: @escaping ((_ name: String, _ description: String, _ image: UIImage?) -> Void)) {
        
        var name = ""
        var description = ""
        
        if let queryDict = jsonDict.object(forKey: "query") as? NSDictionary {
            if let pages = queryDict.object(forKey: "pages") as? NSDictionary {
                if let firstPage = pages.object(forKey: pages.allKeys.first ?? "") as? NSDictionary {
                    if let title = firstPage["title"] as? String  {
                        name = title
                    }
                    
                    if let unparsedDescription = firstPage["extract"] as? String {
                        description = unparsedDescription
                    }
                    
                    if let thumbnailDict = firstPage["thumbnail"] as? NSDictionary {
                        if let thumbnailURLString = thumbnailDict["source"] as? String {
                            
                            
                            if let url = URL(string: thumbnailURLString) {
                                var request = URLRequest(url: url)
                                request.httpMethod = "GET" // should be default setting, but just making this a point
                                //        request.timeoutInterval = 10
                                let dataTask = session.dataTask(with: request) { (data, response, err) in
                                    if err != nil {
                                        print(err ?? "error_alt")
                                    }
                                    
                                    if let imageData = data {
                                        let image = UIImage(data: imageData)
                                        completion(name, description, image)
                                        return
                                    }
                                    
                                    // if no image is extracted
                                    print("no physicist image found!")
                                    completion(name, description, nil)
                                }
                                
                                dataTask.resume()
                            }
                            
                            
                        }
                    }
                    
                }
            }
        }

    }
    
    /// decides on url for next physicist to display based on past views
    func getNextURL() -> URL? {
        // mod count since index must be < num items
        currentNameIndex = (currentNameIndex + 1) % names.count
        let nextName = names[currentNameIndex]
        
        let urlString = "https://en.wikipedia.org/w/api.php?action=query&generator=search&format=json&exintro&exsentences=3&exlimit=max&gsrlimit=1&gsrsearch=hastemplate:\(nextName)&pithumbsize=400&pilimit=max&prop=pageimages%7Cextracts"
        
        let _ = "https://en.wikipedia.org/w/api.php?&action=query&generator=search&format=json&gsrnamespace=0&gsrlimit=1&prop=pageimages%7Cextracts&pilimit=1&exintro&exsentences=1&exlimit=1&continue&pithumbsize=400&gsrsearch=hastemplate:Birth_date+\(nextName.escape)"
        
        return URL(string: urlString)
    }
    
}