//
//  MainDetailCastTableViewCell.swift
//  TMDBProject
//
//  Created by 송황호 on 2022/08/07.
//

import UIKit

import Kingfisher

class MainDetailCastTableViewCell: BaseTableViewCell {

    @IBOutlet weak var titleImage: UIImageView!
    
    @IBOutlet weak var realNameLabel: UILabel!
    
    @IBOutlet weak var castingNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setDesign()
    }
    
    
    func setData(credit: CreditsModel) {
        
        realNameLabel.text = credit.realName
        castingNameLabel.text = credit.castingName
        let url = URL(string: credit.profileImage)
        titleImage.kf.setImage(with: url)
    }
    
    func setDesign() {
        titleImage.layer.cornerRadius = 10
        
        realNameLabel.text = "HwangHo Song"
        realNameLabel.textColor = Color.BaseColor.FontColor
        realNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        castingNameLabel.text = "JungJea Lee / 28"
        castingNameLabel.textColor = Color.BaseColor.FontColor
        castingNameLabel.font = UIFont.systemFont(ofSize: 14)
    }
}
