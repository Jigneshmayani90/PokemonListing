//
//  PokemonCell.swift
//  Pokemon
//
//  Created by Rahul Mayani on 13/07/21.
//

import UIKit

class PokemonCell: UITableViewCell {
    
    // MARK: - Variable -
    var pok : PokeDetailsModel? {
        didSet {
            guard let data = pok else { return }
            pokNameLabel.text = data.name
            pokImage.downloadImageFrom(link: data.sprites.front_default, contentMode: .scaleAspectFit)
        }
    }
        
    private let pokNameLabel : UILabel = AppCustomViews.getLabel(font: UIFont.systemFont(ofSize: 16, weight: .medium))
    private let pokImage : UIImageView = AppCustomViews.getImageView()
    
    // MARK: - Cell Life Cycle -
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(pokImage)
        addSubview(pokNameLabel)
        
        pokImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 50, height: 50, enableInsets: false)
        pokNameLabel.anchor(top: topAnchor, left: pokImage.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0, enableInsets: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK:- ReuseIdentifier -
    class func getIdentifier() -> String {
        return String(describing: self)
    }
}
