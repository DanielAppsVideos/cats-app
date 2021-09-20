//
//  ViewController.swift
//  the_ultimate_cat_breed_Battle
//
//  Created by danielapps on 17/09/21.
//

import UIKit
//TODO: rename to BreedVoterViewController


class VoteCatBreedViewController: UIViewController {
    
    var catBreeds:[UICatBreed] = []
    
    let presenter = CatBreedPresenter.instance
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var catBreedImage: UIImageView!
    @IBOutlet weak var catBreedName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: show spinning indicator and put breedProgress in closure below
        loading.startAnimating()
        presenter.getCatBreeds(onCompletion: { uiCatBreed in
            // response
            //TODO: Stop spinning indicator
            self.catBreeds = uiCatBreed
            self.setUIVoteCatBreed(self.catBreeds)
            self.loading.stopAnimating()
            
        }, onError: {error in
            //TODO: show any error with UIAlertViewController
            self.showErrorMessage()
        })

        
    }
    
   
    
    @IBAction func didTapLikeCatBreed(_ sender: UIButton) {
        //TODO: Add like to breed here. Same in local persistency
//        let userDidPressLike = sender.tag == 1
        
        /*
        let vote = catBreeds[currentBreedIndex]
        vote.isLike = userDidPressLike
        presenter.saveVote(vote)
        */

        showTheNextBreed()
    }
    @IBAction func didTapDislikeCatBreed(_ sender: UIButton) {
        
        
    }
    @IBAction func didTapBreedsList(_ sender: UIButton) {
        guard let toBreedListVC = (storyboard?.instantiateViewController(identifier: "BreedListVC")) as? BreedListViewController else {return}
        toBreedListVC.catBreeds = catBreeds
        navigationController?.pushViewController(toBreedListVC, animated: true)
    }
    @IBAction func didTapVotingRecord(_ sender: UIButton) {
        guard let toVotingRecord = (storyboard?.instantiateViewController(identifier: "VotingRecordVC")) as? VotingRecordViewController else {return}
        toVotingRecord.catBreeds = catBreeds
        navigationController?.present(toVotingRecord, animated: true, completion: nil)
    }
    
    
}

extension VoteCatBreedViewController{
    
    func showTheNextBreed(){
//        let isNotTheLastBreed = currentBreedIndex < catBreeds.count - 1

//        if isNotTheLastBreed{
        if presenter.isNotTheLastBreed(){
            presenter.catBreedProgressStatus.currentIndex += 1
            let currentCatBreedIndex = presenter.catBreedProgressStatus.currentIndex
            let currentCatBreed = presenter.catBreedProgressStatus.breeds[currentCatBreedIndex]
            
//            catBreedName.text = catBreeds[currentBreedIndex].name
            setUIVoteCatBreed(catBreeds)
        }
        
    }
    func showErrorMessage(){
        let alert = UIAlertController(title: "An error has occurred!", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        
        
        self.present(alert, animated: true)
    }

    func setUIVoteCatBreed(_ catBreed: [UICatBreed]){
        let currentCatBreedIndex = presenter.catBreedProgressStatus.currentIndex
        catBreedName.text = catBreed[currentCatBreedIndex].name
    }
}
