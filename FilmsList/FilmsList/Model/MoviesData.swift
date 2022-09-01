//
//  MoviesData.swift
//  FilmsList
//
//  Created by Марат Маркосян on 31.08.2022.
//

import Foundation

struct FilmModel: Equatable, Hashable, Comparable {
    static func < (lhs: FilmModel, rhs: FilmModel) -> Bool {
        return lhs.num < rhs.num
    }
    
    
    let title: String
    let year: Int
    let num: Int
    
}

struct Storage {
    
    static var instance = Storage()
    
    var films = Set<FilmModel>()
}
