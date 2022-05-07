//
//  PokemonListVC.swift
//  Pokemon
//
//  Created by Rahul Mayani on 13/07/21.
//

import UIKit

class PokemonListVC: BaseVC {
    
    // MARK: - Variable -
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .label
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    private let gateway = APIGateway()
    
    private var pokTableView = PagingTableView()
    
    private var refreshControl = UIRefreshControl()
    
    private var isLoadMore = false
    
    private var limit = 15
    
    private var searchData: [PokeDetailsModel] = []

    // MARK: - View Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokemon"
        // TableView
        setPokTableView()
        // SearchBar
        navigationItem.searchController = self.searchController
        searchController.isActive = true
        //Get Data
        gateway.delegate = self
        gateway.dataList = DBManager.shared.fetchPoksFromDB()
        if gateway.dataList.count == 0 {
            gateway.getPokemons()
        }
        //Refresh Control
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: UIControl.Event.valueChanged)
        pokTableView.addSubview(refreshControl)
        //Paginate
        pokTableView.pagingDelegate = self
    }
    
    // MARK: - Others -
    @objc
    private func pullToRefresh() {
        refreshControl.beginRefreshing()
        pokTableView.reset()
        gateway.getPokemons(isLoader: false)
    }
}

// MARK: - Setup UI & Cells
extension PokemonListVC {
    func setPokTableView() {
        pokTableView.register(PokemonCell.self, forCellReuseIdentifier: PokemonCell.getIdentifier())
        view.addSubview(pokTableView)
        pokTableView.delegate = self
        pokTableView.dataSource = self
        pokTableView.rowHeight = UITableView.automaticDimension
        pokTableView.estimatedRowHeight = UITableView.automaticDimension
        pokTableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
}

//MARK: - UISearchBar Delegate
extension PokemonListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchData = gateway.dataList.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        pokTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchData = []
        searchBar.searchTextField.resignFirstResponder()
        searchController.isActive = false
        pokTableView.reloadData()
    }
}

// MARK:- APIGatewayProtocol -
extension PokemonListVC: APIGatewayProtocol {
    func getPokResponse(success: Bool, isLoadMore: Bool) {
        pokTableView.isLoading = false
        self.isLoadMore = isLoadMore
        refreshControl.endRefreshing()
        pokTableView.reloadData()
    }
}

// MARK: - PagingTableViewDelegate -
extension PokemonListVC: PagingTableViewDelegate {
    func paginate(_ tableView: PagingTableView, to page: Int) {
        if !pokTableView.isLoading && isLoadMore && !searchController.isActive {
            pokTableView.isLoading = true
            gateway.getPokemons(offset: gateway.dataList.count, isLoader: false)
        }
    }
}

//MARK:- UITableView Methods
extension PokemonListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? searchData.count : gateway.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  PokemonCell.getIdentifier()) as! PokemonCell
        cell.pok = searchController.isActive ? searchData[indexPath.row] : gateway.dataList[indexPath.row]
        pokTableView.paginate(pokTableView, forIndexAt: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let data = searchController.isActive ? searchData[indexPath.row] : gateway.dataList[indexPath.row]
        let detailsVC = PokemonDetailsVC()
        detailsVC.pokDetails = data
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
