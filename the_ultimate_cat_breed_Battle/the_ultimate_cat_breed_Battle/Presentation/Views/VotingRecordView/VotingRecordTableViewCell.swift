//
//  BreedInfoTableViewCell.swift
//  the_ultimate_cat_breed_Battle
//
//  Created by danielapps on 18/09/21.
//

import UIKit

class VotingRecordTableViewCell: UITableViewCell {
    
    static let nib = UINib(nibName: "VotingRecordTableViewCell", bundle: nil)
    static let identifier = "VotingRecordVC"
    
    @IBOutlet weak var breedVote: UILabel!
    @IBOutlet weak var breedName: UILabel!
    @IBOutlet weak var breedDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        breedVote.layer.cornerRadius = 10
        
    }
    //date format:MMM d, h:mm a
    func setUIVotingRecord(_ catBreed: UICatBreed){
        breedName.text = catBreed.name
        
        breedDate.text = catBreed.voteDate
        setBreedVote(catBreed)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension VotingRecordTableViewCell {
    
    func setBreedVote(_ catBreed: UICatBreed){
        guard let isLiked = catBreed.isLiked else {return}
        if isLiked {
            breedVote.text = "Like"
            breedVote.backgroundColor = UIColor(named: "green")
        } else {
            breedVote.text = "Dislike"
            breedVote.backgroundColor = UIColor(named: "red")
        }
    }
}


