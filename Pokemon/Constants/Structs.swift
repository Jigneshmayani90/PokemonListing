//
//  Structs.swift
//  Pokemon
//
//  Created by Rahul Mayani on 13/07/21.
//

import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate

public struct APIEndPoint {
    
    static let endPointURL = Environment.production.rawValue + "v2/"
        
    enum Environment:String {
        case develop = "http://local/"
        case staging = "https://stage/"
        case production = "https://pokeapi.co/api/"
    }
    
    struct Name {
        static let pokemon = endPointURL + "pokemon"
    }
}
