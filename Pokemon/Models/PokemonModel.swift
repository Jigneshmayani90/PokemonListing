//
//  PokemonModel.swift
//  Pokemon
//
//  Created by Rahul Mayani on 13/07/21.
//

import Foundation

struct PokeAPIModel: Codable {
    var count: Int64!
    var results: [PokemonModel]!
    var next: String?
    var previous: String?
}


struct PokemonModel: Codable {
    var name: String!
    var url: String!
}
