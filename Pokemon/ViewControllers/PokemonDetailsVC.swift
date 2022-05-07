//
//  PokemonDetailsVC.swift
//  Pokemon
//
//  Created by Rahul Mayani on 13/07/21.
//

import UIKit

class PokemonDetailsVC: BaseVC {
    
    // MARK: - Variable -
    var pokDetails: PokeDetailsModel? = nil
    
    private let heightLabel : UILabel = AppCustomViews.getLabel(textColor: .black)
    private let weightLabel : UILabel = AppCustomViews.getLabel(textColor: .black)
    private let abilitiesLabel : UILabel = AppCustomViews.getLabel(textColor: .black)
    private let typesLabel : UILabel = AppCustomViews.getLabel(textColor: .black)
    private let pokImage : UIImageView = AppCustomViews.getImageView()
    
    private let stackView: UIStackView = AppCustomViews.getStackView()
    
    // MARK: - View Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        title = pokDetails?.name ?? ""
        setUIPokDetailsView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDatasourcePokDetailsView()
    }
}

// MARK: - Setup UI
extension PokemonDetailsVC {
    func setUIPokDetailsView() {
        stackView.addArrangedSubview(pokImage)
        stackView.addArrangedSubview(heightLabel)
        stackView.addArrangedSubview(weightLabel)
        stackView.addArrangedSubview(abilitiesLabel)
        stackView.addArrangedSubview(typesLabel)
        stackView.addSubview(AppCustomViews.getSpacerView())
        
        view.addSubview(stackView)
        
        stackView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 100, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0, enableInsets: false)
    }
}

// MARK: - Datasource
extension PokemonDetailsVC {
    func setDatasourcePokDetailsView() {
        guard let data = pokDetails else { return }
        pokImage.downloadImageFrom(link: data.sprites.front_default, contentMode: .scaleAspectFit)
        heightLabel.text = "Height: \(data.height ?? 0)"
        weightLabel.text = "Weight: \(data.weight ?? 0)"
        abilitiesLabel.text = "Abilities: " + (data.abilities.map({ $0 })?.map({ $0.ability.name }).joined(separator: ", ") ?? "")
        typesLabel.text = "Types: " + (data.types.map({ $0 })?.map({ $0.type.name }).joined(separator: ", ") ?? "")
    }
}
