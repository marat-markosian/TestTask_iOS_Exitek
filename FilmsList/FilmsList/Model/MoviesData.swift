//
//  MoviesData.swift
//  FilmsList
//
//  Created by Марат Маркосян on 31.08.2022.
//

import Foundation

struct FilmModel {
    
    let title: String
    let year: Int
    
}

struct Storage {
    
    static var instance = Storage()
    
    var films = [FilmModel]()
}
