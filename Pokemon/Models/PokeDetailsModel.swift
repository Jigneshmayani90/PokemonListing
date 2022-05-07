//
//  PokeDetailsModel.swift
//  Pokemon
//
//  Created by Rahul Mayani on 13/07/21.
//

import Foundation
import CoreData

struct PokeDetailsModel : Codable{

    var abilities: [AbilitiesModel]!
    var name: String!
    var id: Int64!
    var weight: Int!
    var height: Int!
    var types: [TypesModel]!
    var sprites: Sprites!
    /*
    enum CodingKeys: String, CodingKey {
        case id, name, height, weight
        case sprites = "images"
    }*/
}

struct AbilitiesModel : Codable{
    var ability: AbilitieModel!
}

struct AbilitieModel : Codable{
    var name: String!
}

struct Sprites: Codable {
    var back_default : String!
    var back_shiny : String!
    var front_default : String!
    var front_shiny : String!
}

struct TypesModel : Codable{
    var type: TypeModel!
}

struct TypeModel : Codable{
    var name: String!
}

extension PokeDetailsModel {
    
    static func setDBData(data: DBPokeDetails) -> PokeDetailsModel {
        var pokeDetailsModel = PokeDetailsModel()
        pokeDetailsModel.id = data.id
        pokeDetailsModel.name = data.name
        pokeDetailsModel.weight = Int(data.weight)
        pokeDetailsModel.height = Int(data.height)
        pokeDetailsModel.sprites = Sprites(back_default: data.sprites?.back_default, back_shiny: data.sprites?.back_shiny, front_default: data.sprites?.front_default, front_shiny: data.sprites?.front_shiny)
        var typesDB:[TypesModel] = []
        data.types?.forEach({ (type) in
            guard let type = type as? DBTypes else { return }
            return typesDB.append(TypesModel(type: TypeModel(name: type.name)))
        })
        pokeDetailsModel.types = typesDB
        var abilitiesDB:[AbilitiesModel] = []
        data.abilities?.forEach({ (ab) in
            guard let ab = ab as? DBAbilities else { return }
            return abilitiesDB.append(AbilitiesModel(ability: AbilitieModel(name: ab.name)))
        })
        pokeDetailsModel.abilities = abilitiesDB
        return pokeDetailsModel
    }
}
