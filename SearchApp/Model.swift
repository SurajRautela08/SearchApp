//
//  Model.swift
//  SearchApp
//
//  Created by Suraj on 23/11/20.
//  Copyright © 2020 Suraj. All rights reserved.
//

import Foundation


struct SearchResult : Codable {
    
    let total : Int
    let totalHits : Int
    let hits : [imageData]
    
    
}


struct imageData : Codable {
    let id : Int
    let userImageURL : String
}
