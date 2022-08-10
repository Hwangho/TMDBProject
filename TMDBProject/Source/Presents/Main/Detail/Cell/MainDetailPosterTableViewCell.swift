//
//  MainDetailPosterTableViewCell.swift
//  TMDBProject
//
//  Created by 송황호 on 2022/08/07.
//

import UIKit

class MainDetailPosterTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var poseterImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setDesign()
    }
    
    func setData() {
        
    }

    func setDesign() {
        movieTitleLabel.textColor = .white
        movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
    }
}
