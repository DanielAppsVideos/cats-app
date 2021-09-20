//
//  BreedListTableViewCell.swift
//  the_ultimate_cat_breed_Battle
//
//  Created by danielapps on 18/09/21.
//

import UIKit
import Kingfisher

class BreedListTableViewCell: UITableViewCell {

    static let nib: UINib = UINib(nibName: "BreedListTableViewCell", bundle: nil)
    static let identifier = "BreedListVC"
    
    @IBOutlet weak var catBreedImage: UIImageView!
    @IBOutlet weak var catBreedName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setUICatBreed(_ catBreed: UICatBreed){
        catBreedName.text = catBreed.name
        setcatBreedImage(catBreed)
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension BreedListTableViewCell {
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
