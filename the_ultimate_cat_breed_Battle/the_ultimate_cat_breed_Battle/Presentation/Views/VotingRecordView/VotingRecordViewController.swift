//
//  BreedInfoViewController.swift
//  the_ultimate_cat_breed_Battle
//
//  Created by danielapps on 18/09/21.
//

import UIKit

class VotingRecordViewController: UIViewController {
   
    var catBreeds:[UICatBreed] = []
    var presenter = CatBreedPresenter.instance
    
    @IBOutlet weak var votingRecordTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        votingRecordTableView.delegate = self
        votingRecordTableView.dataSource = self
        votingRecordTableView.register(VotingRecordTableViewCell.nib, forCellReuseIdentifier: VotingRecordTableViewCell.identifier)
        catBreeds = presenter.getVotedCatBreeds()
        // Do any additional setup after loading the view.
    }
   
    @IBAction func didTapGoBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}

extension VotingRecordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catBreeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VotingRecordTableViewCell.identifier, for: indexPath) as! VotingRecordTableViewCell
        
        cell.setUIVotingRecord(catBreeds[indexPath.row])
        
        return cell
    }
    
    
}

extension VotingRecordViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
        
    }
}
