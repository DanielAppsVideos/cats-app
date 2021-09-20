//
//  CatBreedPresenter.swift
//  the_ultimate_cat_breed_Battle
//
//  Created by danielapps on 18/09/21.
//

import Foundation

typealias CallbackBlock<T:Any> = (_ value: [T])->Void
typealias ErrorBlock = (_ error: Error)->Void

struct CatBreedProgressStatus:Codable{
    var currentIndex:Int = 0
    var breeds:[UICatBreed] = []
}


class CatBreedPresenter {
    static let instance: CatBreedPresenter = CatBreedPresenter()
    let catBreedDataService = CatBreedDataService.instance
    let converter:CatBreedUIConverter = CatBreedUIConverter.instance
    var catBreedProgressStatus = CatBreedProgressStatus()
    
    func getCatBreeds(onCompletion: @escaping CallbackBlock<UICatBreed>, onError: ErrorBlock?){
        if isAvaliableSession(){
            
            if let localCatBreedProgressStatus = getlocalCatBreedProgressStatus() {
                loadTheNextCatToVoteFor(localCatBreedProgressStatus)
                onCompletion(catBreedProgressStatus.breeds)
                return
            }
            print("can't load session")
        }
        /*
        if isAvailableSession(){
            let localBreeds = getLocalBreeds()
            onCompletion(localBreeds)
            return
        }
        */
        catBreedDataService.getBreeds(onCompletion: {breeds in
            
            self.catBreedProgressStatus.breeds = self.converter.convert(breeds)
            onCompletion(self.converter.convert(breeds))
            print("on presenter\(self.catBreedProgressStatus.breeds.count)")
            
        }, onError: onError)
    }
    
    func jumpToNextBreedIfPossible() -> Bool{
        let currentIndex = catBreedProgressStatus.currentIndex
        let catBreedCount = catBreedProgressStatus.breeds.count
        let isNotTheLastBreed = currentIndex < catBreedCount - 1
        
        if isNotTheLastBreed {
            catBreedProgressStatus.currentIndex += 1
            return true
        }else {
            return false
        }
        
    }
    
    func saveVote(_ vote: UICatBreed){
        
        catBreedProgressStatus.breeds[catBreedProgressStatus.currentIndex] = vote
        
     
        catBreedDataService.saveBreedsVoting(catBreedProgressStatus)
    }
    
    func isAvaliableSession()->Bool {
        return catBreedDataService.defaults.object(forKey: "savedSession") != nil
    }
    
    
    
    
    /*
    func isAvailableSession()->Bool{
        
        return currentIndex == null
    }
    */

    func getlocalCatBreedProgressStatus() -> CatBreedProgressStatus?{
        
        return catBreedDataService.getSavedSession()
    }
    func loadTheNextCatToVoteFor(_ lastSession: CatBreedProgressStatus){
        catBreedProgressStatus = lastSession
        catBreedProgressStatus.currentIndex += 1
    }
    
    func getVotedCatBreeds() -> [UICatBreed]{
        
        return catBreedProgressStatus.breeds.filter{ catBreed in
            
            return catBreed.isLiked != nil
        }
    }
    
    func convertUIdate(_ date: Date) -> String{
        return converter.dateUIConverter(date)
    }
    
}
