//
//  BreedDescriptionViewController.swift
//  the_ultimate_cat_breed_Battle
//
//  Created by danielapps on 18/09/21.
//

import UIKit
import Kingfisher

class BreedDescriptionViewController: UIViewController {
    
    var catBreed:UICatBreed?
    
    @IBOutlet weak var breedName: UILabel!
    @IBOutlet weak var breedImage: UIImageView!
    @IBOutlet weak var breedDescription: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIBreedDescription()
    }
    
    @IBAction func didTapGoBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func setUIBreedDescription(){
        breedName.text = catBreed?.name
        breedDescription.text = catBreed?.description
        guard let urlImage = catBreed?.image else {return}
        breedImage.kf.setImage(with: URL(string: urlImage))
        
    }
    
    

}
