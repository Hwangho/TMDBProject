//
//  MainDetailPosterTableViewCell.swift
//  TMDBProject
//
//  Created by 송황호 on 2022/08/07.
//

import UIKit

import Kingfisher


class MainDetailPosterTableViewCell: BaseTableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var poseterImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setDesign()
    }
    
    func setData(title: String, backImage: String?, posterImage: String?) {
        
        movieTitleLabel.text = title
        movieTitleLabel.textColor = .white
        
        if let backImage = backImage, let posterImage = posterImage {
            let backurl = URL(string: backImage)
            backgroundImage.kf.setImage(with: backurl)
            let posterurl = URL(string: posterImage)
            poseterImage.kf.setImage(with: posterurl)
        } else { }


    }

    func setDesign() {
        movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        movieTitleLabel.textColor = Color.BaseColor.FontColor
    }
}
