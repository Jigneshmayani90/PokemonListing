//
//  AppCustomViews.swift
//  Pokemon
//
//  Created by Rahul Mayani on 13/07/21.
//

import UIKit

struct AppCustomViews {
    
    // create spacer view programmatically
    static func getSpacerView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.sizeToFit()
        return view
    }
        
    // create imageview programmatically
    static func getImageView() -> UIImageView {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        //img.layer.cornerRadius = 10
        img.clipsToBounds = true
        return img
    }

    // create label programmatically with changing font, lines, text color and alignment
    static func getLabel(font: UIFont = UIFont.systemFont(ofSize: 14, weight: .semibold), numberOfLines: Int = 0, textColor: UIColor = .black, textAlignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor =  textColor
        label.sizeToFit()
        label.numberOfLines = numberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = textAlignment
        return label
    }

    // create stackview programmatically with changing spacing between subviews and axis direction
    static func getStackView(spacing: CGFloat = 10.0, axis: NSLayoutConstraint.Axis = .vertical) -> UIStackView {
        let stackViewIdType = UIStackView()
        stackViewIdType.axis = axis
        stackViewIdType.spacing = spacing
        stackViewIdType.distribution = .fillProportionally
        stackViewIdType.translatesAutoresizingMaskIntoConstraints = false
        return stackViewIdType
    }
}
