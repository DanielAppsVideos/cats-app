//
//  CatBreed.swift
//  the_ultimate_cat_breed_Battle
//
//  Created by danielapps on 18/09/21.
//

import Foundation


struct CatBreed : Decodable {
    let name: String?
    let image: Image?
    let description: String?
}

struct Image : Decodable {
    let url:String?
}
