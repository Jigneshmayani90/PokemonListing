//
//  DBManager.swift
//  Pokemon
//
//  Created by Rahul Mayani on 13/07/21.
//

import UIKit
import CoreData

enum DBEntities: CaseIterable {
    case dbPokeDetails
    case dbSprites
    case dbTypes
    case dbAbilities
    
    var name: String {
        switch self {
        case .dbPokeDetails:
            return "DBPokeDetails"
        case .dbSprites:
            return "DBSprites"
        case .dbTypes:
            return "DBTypes"
        case .dbAbilities:
            return "DBAbilities"
        }
    }
}

class DBManager {
    // MARK: - ManagedContext
    let managedContext = PersistantStorage.shared.context
    
    // MARK: - Get Instance
    static let shared = DBManager()
    
    // MARK: - Fetch Query
    func fetchQuery(entity: String, completionSuccess: (_ response: [NSManagedObject]) -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        request.returnsObjectsAsFaults = false
        do {
            let result = try managedContext.fetch(request)
            completionSuccess(result as! [NSManagedObject])
        } catch let error as NSError {
            print("Failed fetchSettingsResult error :- \(error.localizedDescription)")
        }
    }
    
    // MARK: - Save -
    func saveData() {
        do {
            try managedContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension DBManager {
    
    func savePokWith(_ data: PokeDetailsModel) {
        if let entityDesc = NSEntityDescription.entity(forEntityName: DBEntities.dbPokeDetails.name, in: managedContext) {
            let pok = NSManagedObject(entity: entityDesc, insertInto: managedContext) as! DBPokeDetails
            pok.name = data.name
            pok.id = data.id
            pok.height = Int16(data.height)
            pok.weight = Int16(data.weight)
            if let abilitiesDesc = NSEntityDescription.entity(forEntityName: DBEntities.dbAbilities.name, in: managedContext) {
                let abilities: [DBAbilities] = data.abilities.map({ $0 }).map({
                    let abilitie = NSManagedObject(entity: abilitiesDesc, insertInto: managedContext) as! DBAbilities
                    abilitie.name = $0.ability.name
                    return abilitie
                })
                pok.abilities?.addingObjects(from: abilities)
            }
            if let typesDesc = NSEntityDescription.entity(forEntityName: DBEntities.dbTypes.name, in: managedContext) {
                let types: [DBTypes] = data.types.map({ $0 }).map({
                    let type = NSManagedObject(entity: typesDesc, insertInto: managedContext) as! DBTypes
                    type.name = $0.type.name
                    return type
                })
                pok.types?.addingObjects(from: types)
            }
            if let spritesDesc = NSEntityDescription.entity(forEntityName: DBEntities.dbSprites.name, in: managedContext) {
                let sprites = NSManagedObject(entity: spritesDesc, insertInto: managedContext) as! DBSprites
                sprites.back_shiny = data.sprites.back_shiny
                sprites.back_default = data.sprites.back_default
                sprites.front_shiny = data.sprites.front_shiny
                sprites.front_default = data.sprites.front_default
                pok.sprites = sprites
            }
            saveData()
        }
    }
    
    func fetchPoksFromDB() -> [PokeDetailsModel]{
        var pokData = [PokeDetailsModel]()
        fetchQuery(entity: DBEntities.dbPokeDetails.name) { (fetchedObj) in
            pokData = fetchedObj.reduce(into: [PokeDetailsModel]()) { (obj, pok) in
                guard let pok = pok as? DBPokeDetails else { return }
                obj.append(PokeDetailsModel.setDBData(data: pok))
            }
        }
        return pokData
    }
}
