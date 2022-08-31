//
//  CustomCell.swift
//  FilmsList
//
//  Created by Марат Маркосян on 31.08.2022.
//

import UIKit

class CustomCell: UITableViewCell {

    private lazy var filmLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setLabel() {
        addSubview(filmLabel)
        backgroundColor = .white
        
        filmLabel.translatesAutoresizingMaskIntoConstraints = false
        
        filmLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        filmLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        filmLabel.textColor = .black
        
    }
    
    
    func setFilmInfo(to name: String) {
        filmLabel.text = name
    }

}
