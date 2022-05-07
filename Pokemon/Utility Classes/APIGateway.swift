//
//  APIGateway.swift
//  Pokemon
//
//  Created by Rahul Mayani on 13/07/21.
//

import UIKit

// MARK: - APIGateway Protocol -
protocol APIGatewayProtocol: class {
    func getPokResponse(success: Bool, isLoadMore: Bool)
}

// MARK: - APIGateway Class -
class APIGateway {
    // MARK: - Variable -
    var totalPokes: Int64 = 0
    
    var dataList: [PokeDetailsModel] = []
    
    let dispatchGroup = DispatchGroup()
    
    weak var delegate: APIGatewayProtocol?
}

// MARK: - API -
extension APIGateway {
    func getPokemons(offset: Int = 0, isLoader: Bool = true) {
        /// Reachability
        if !AppNetworkReachability.isInternetAvailable() {
            UIAlertController.showAlert(message: AppMessages.noInternetConnection)
            return
        }
        
        /// Loader
        if isLoader {
            AppLoader.startLoaderToAnimating()
        }
                        
        URLSession.shared.dataTask(with: URL(string: APIEndPoint.Name.pokemon + "?offset=\(offset)&limit=20")!) { [weak self] (data, response, error) in
            if let data = data {
                do {
                    let pok = try! JSONDecoder().decode(PokeAPIModel.self, from: data)
                    var pokListData: [PokeDetailsModel] = []
                    pok.results.forEach { [weak self] (poke) in
                        self?.dispatchGroup.enter()
                        URLSession.shared.dataTask(with: URL(string: poke.url)!) { [weak self] (data, response, error) in
                            if let data = data {
                                do {
                                    let pok = try! JSONDecoder().decode(PokeDetailsModel.self, from: data)
                                    pokListData.append(pok)
                                    if offset == 0 && isLoader {
                                        DBManager.shared.savePokWith(pok)
                                    }
                                    self?.dispatchGroup.leave()
                                }
                            }
                        }.resume()
                    }
                    /// Get all Data when dispatchGroup notify
                    self?.dispatchGroup.notify(queue: .main) { [weak self] in
                        if offset == 0 {
                            self?.dataList = pokListData
                        } else {
                            self?.dataList = (self?.dataList ?? []) + pokListData
                        }
                        self?.dataList.sort(by: { $0.id < $1.id })
                        AppLoader.stopLoaderToAnimating()
                        #warning("Fetching up to 300 Pokemon")
                        self?.delegate?.getPokResponse(success: true, isLoadMore: (/*(self?.totalPokes ?? 0)*/300 != self?.dataList.count ?? 0))
                    }
                }
            }
            if let error = error {
                AppLoader.stopLoaderToAnimating()
                UIAlertController.showAlert(message: error.localizedDescription)
                self?.delegate?.getPokResponse(success: false, isLoadMore: false)
            }
        }.resume()
    }
}
