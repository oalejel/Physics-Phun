//
//  PhysicistOfTheDayManager.swift
//  Physics Phun
//
//  Created by Omar Al-Ejel on 7/22/18.
//  Copyright © 2018 omaralejel. All rights reserved.
//

import Foundation

/// Responsible for fetching data about an interesting physicist 
class PhysicistOfTheDayManager {
    
//    var completionHandler: ((name: String, description: String, ) -> Void)?
    
    static var shared: PhysicistOfTheDayManager = PhysicistOfTheDayManager()
    
    func update(completionHandler: ((_ name: String, _ description: String, _ url: URL) -> Void) ) {
        // request data related to a physicist
        
        // on completion, we call the completion handler
        completionHandler("Leibniz", "What a great dude. He did a lot of nice things. This is a short descriptiont that will inform users.", URL(fileURLWithPath: ""))
    }
    
}
