//
//  ViewController.swift
//  the_ultimate_cat_breed_Battle
//
//  Created by danielapps on 17/09/21.
//

import UIKit
import Kingfisher
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
        var vote = catBreeds[presenter.catBreedProgressStatus.currentIndex]
        let currentDateTime = Date()
        
        switch UserVote(rawValue:sender.tag)! {
        case UserVote.like:
            vote.isLiked = true

        case UserVote.dislike:
            vote.isLiked = false
                   
        }
       
        vote.voteDate = presenter.convertUIdate(currentDateTime)
        presenter.saveVote(vote)
        showTheNextBreed()
    }
    
    @IBAction func didTapDislikeCatBreed(_ sender: UIButton) {
    }
    
    @IBAction func didTapBreedsList(_ sender: UIButton) {
        guard let toBreedListVC = (storyboard?.instantiateViewController(identifier: "BreedListVC")) as? BreedListViewController else {return}
        toBreedListVC.catBreeds = presenter.catBreedProgressStatus.breeds // debo usar el presenter?
        navigationController?.pushViewController(toBreedListVC, animated: true)
    }
    @IBAction func didTapVotingRecord(_ sender: UIButton) {
        guard let toVotingRecord = (storyboard?.instantiateViewController(identifier: "VotingRecordVC")) as? VotingRecordViewController else {return}
        toVotingRecord.catBreeds = presenter.catBreedProgressStatus.breeds
        navigationController?.present(toVotingRecord, animated: true, completion: nil)
    }
}

extension VoteCatBreedViewController{
    
    func showTheNextBreed(){
        if presenter.jumpToNextBreedIfPossible(){
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
        setcatBreedImage(catBreed[currentCatBreedIndex])
    }
    
    func setcatBreedImage(_ catBreed: UICatBreed){
        let url = URL(string: catBreed.image)
        let processor = DownsamplingImageProcessor(size: catBreedImage.bounds.size)
            |> RoundCornerImageProcessor(cornerRadius: 15)
        catBreedImage.kf.indicatorType = .activity
        catBreedImage.kf.setImage(with: url,
                                  placeholder: UIImage(named: "placeholderImage"),
                                  options: [
                                    .processor(processor),
                                    .scaleFactor(UIScreen.main.scale),
                                    .cacheOriginalImage
                                  ]){
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        
    }
}

enum UserVote: Int {
    case like
    case dislike
}
