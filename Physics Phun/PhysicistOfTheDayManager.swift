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
    
    var currentNameIndex = 0
    fileprivate let currentNameKey = "currentNameKey"
    var names = [
        "Marie_Curie",
        "Isaac_Newton",
        "Albert_Einstein",
        "Richard_Feynman",
        "Rosalind_Franklin",
        "Niels_Bohr",
        "Lise_Meitner",
        "Blaise_Pascal",
        "Max_Planck",
        "Galileo_Galilei",
        "James_Chadwick",
        "Carl_Sagan",
        "Georg_Ohm",
//        "Eva_Silverstein",
        "Satyendra_Nath_Bose",
        "Wolfgang_Pauli",
        "Christiaan_Huygens",
        "Louis_de_Broglie",
        "Erwin_Schrodinger"
    ]
    
    static var shared: PhysicistOfTheDayManager = PhysicistOfTheDayManager()
    var session: URLSession!
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config, delegate: nil, delegateQueue: nil)
        let defaults = UserDefaults.standard
        
        // if no int exists for this key, we default to 0, which is good
        currentNameIndex = defaults.integer(forKey: currentNameKey)
    }
    
    /// decides on url for next physicist to display based on past views
    func getNextURL() -> URL? {
        // mod count since index must be < num items
//        currentNameIndex = (currentNameIndex + 1) % names.count
        let nextName = names[currentNameIndex]
        
        let urlString = "https://en.wikipedia.org/w/api.php?action=query&generator=search&format=json&exintro&exsentences=3&exlimit=max&gsrlimit=1&gsrsearch=\(nextName)&pithumbsize=400&pilimit=max&prop=pageimages%7Cextracts"
        
        // increment name and save for next time
        currentNameIndex = (currentNameIndex + 1) % names.count
        let defaults = UserDefaults.standard
        defaults.set(currentNameIndex, forKey: currentNameKey)
        
        return URL(string: urlString)
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
                    /*
                        - must remove all tabs and types of non space spaces. even newlines
                        - everything between <> must go
                        - all semicolons
                        - occurrences of &#some_numbers;
                    */
                    if var unparsedDescription = firstPage["extract"] as? String {
//                        print(unparsedDescription)

                        removeSubstringEnclosedIn(leftCharacter: "<", rightCharacter: ">", forString: &unparsedDescription)
                        removeSubstringEnclosedIn(leftCharacter: "(", rightCharacter: ")", forString: &unparsedDescription)
                        removeSubstringEnclosedIn(leftCharacter: "[", rightCharacter: "]", forString: &unparsedDescription)
                        
                        // removes occurrences of strings
                        unparsedDescription = unparsedDescription.replacingOccurrences(of: "&#160;", with: "")
                        // especially double spaces
                        unparsedDescription = unparsedDescription.replacingOccurrences(of: "  ", with: " ")
                        
                        // only removed individual characters
                        let unwanted: [Character] = ["\n", "\t", ";"]
                        for (index, c) in unparsedDescription.enumerated().reversed() {
                            if unwanted.contains(c) {
                                let stringIndex = unparsedDescription.index(unparsedDescription.startIndex, offsetBy: index)
                                unparsedDescription.remove(at: stringIndex)
                            }
                        }
                        
//                        unparsedDescription.removeAll { (c) -> Bool in
//                            return unwanted.contains(c)
//                        }
                        
                        description = unparsedDescription
                    }
                    
                    if let thumbnailDict = firstPage["thumbnail"] as? NSDictionary {
                        if let thumbnailURLString = thumbnailDict["source"] as? String {
                            if let url = URL(string: thumbnailURLString) {
                                var request = URLRequest(url: url)
                                request.httpMethod = "GET" // should be default setting, but just making this a point
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
    
    func removeSubstringEnclosedIn(leftCharacter c1: Character, rightCharacter c2: Character, forString str: inout String) {
        // #warning("change in next version of swift")
        var removalRanges: [(String.Index?, String.Index?)] = []
        for (index, ch) in str.enumerated().reversed() {
            if ch == c2 {
                // prepare for the closing angled bracket
                let intToIndex = str.index(str.startIndex, offsetBy: index)
                removalRanges.append((intToIndex, nil))
            } else if ch == c1 {
//                #warning("return this version in swift 4.2")
                //                if let lastUnpairedIndex = removalRanges.lastIndex(where: { (pair) -> Bool in
                //                    return pair.1 == nil // take first pair that has no matched "<" in .1
                //                }) {
                //                    let intToIndex = str.index(str.startIndex, offsetBy: index)
                //                    removalRanges[lastUnpairedIndex].1 = intToIndex
                //                    str.removeSubrange(removalRanges[lastUnpairedIndex].1!...removalRanges[lastUnpairedIndex].0!)
                //                }
                var lastUnpairedIndex: Int?
                for (index, pair) in removalRanges.enumerated().reversed() {
                    if pair.1 == nil {
                        lastUnpairedIndex = index
                        break
                    }
                }
                if let i = lastUnpairedIndex {
                    let intToIndex = str.index(str.startIndex, offsetBy: index)
                    removalRanges[i].1 = intToIndex
                    str.removeSubrange(removalRanges[i].1!...removalRanges[i].0!)
                }

//                #warning("return this implementation on swift 4.2 when xcode 10 apps can be published")
//                if let lastUnpairedIndex = removalRanges.lastIndex(where: { (pair) -> Bool in
//                    return pair.1 == nil // take first pair that has no matched "<" in .1
//                }) {
//                    let intToIndex = str.index(str.startIndex, offsetBy: index)
//                    removalRanges[lastUnpairedIndex].1 = intToIndex
//                    str.removeSubrange(removalRanges[lastUnpairedIndex].1!...removalRanges[lastUnpairedIndex].0!)
//                }
            }
        }
    }
    
}
