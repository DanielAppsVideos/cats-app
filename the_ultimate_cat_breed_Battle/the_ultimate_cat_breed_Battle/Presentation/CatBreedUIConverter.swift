//
//  CatBreedUIConverter.swift
//  the_ultimate_cat_breed_Battle
//
//  Created by danielapps on 18/09/21.
//

import Foundation



struct UICatBreed:Codable {
    let name:String
    let image:String
    let description:String
    var isLiked: Bool?
    var voteDate: String?
    
}

class CatBreedUIConverter {
    static let instance:CatBreedUIConverter = CatBreedUIConverter()
    
    func convert(_ catBreed: [CatBreed])-> [UICatBreed]{
        
        return catBreed.map({ catBreed in
            return convertCatBreed(catBreed)
        })
    
    }
    
    func convertCatBreed(_ catBreed: CatBreed)-> UICatBreed {
        let name = catBreed.name ?? ""
        let imageUrl = catBreed.image?.url ?? ""
        let description = catBreed.description ?? ""
        
        return UICatBreed(name: name, image: imageUrl, description: description)
        
    }
    
    func dateUIConverter(_ date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: date)
        
    }
}
