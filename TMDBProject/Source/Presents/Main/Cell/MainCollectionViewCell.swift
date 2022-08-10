//
//  MainCollectionViewCell.swift
//  TMDBProject
//
//  Created by 송황호 on 2022/08/04.
//

import UIKit

import Kingfisher

class MainCollectionViewCell: UICollectionViewCell {

    static let identifier = "MainCollectionViewCell"
    
    
    @IBOutlet weak var clipButton: UIButton!
    
    @IBOutlet weak var titleImage: UIImageView!
    
    @IBOutlet weak var averageLabel: UILabel!
    
    @IBOutlet weak var averageNumLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var detailButton: UIButton!
    
    @IBOutlet weak var cardView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setDesign()
    }
    
    
    /// Custom func
    func setData(data :TrendingModel) {
        titleLabel.text = data.title
        averageNumLabel.text = String(format: "%.1f", data.vote_average)
        contentLabel.text = data.overview
        
        guard let poserURL = data.poster_path else {return}
        let url = URL(string: poserURL)
        titleImage.kf.setImage(with: url)
    }
    
    func setDesign() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "paperclip.circle.fill", withConfiguration: largeConfig)
        clipButton.setImage(largeBoldDoc, for: .normal)
        clipButton.tintColor = .white
        
        titleImage.contentMode = .scaleAspectFill
        
        averageLabel.backgroundColor = .purple
        averageLabel.textColor = .white
        averageLabel.text = "평점"
        averageLabel.font = UIFont.systemFont(ofSize: 11)
        averageLabel.textAlignment = .center
        
        averageNumLabel.textColor = .black
        averageNumLabel.text = "0.0"
        averageNumLabel.font = UIFont.systemFont(ofSize: 11)
        
        titleLabel.textColor = .black
        titleLabel.text = "이건 무슨 영화일까요~!?"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
    
        contentLabel.textColor = .black.withAlphaComponent(0.6)
        contentLabel.text = "이건 무슨 영화일까요~!? 이건 무슨 영화일까요~!? 이건 무슨 영화일까요~!?"
        contentLabel.font = UIFont.systemFont(ofSize: 13)
        
        lineView.backgroundColor = .black
        
        detailLabel.textColor = .black
        detailLabel.text = "자세히 보기"
        detailLabel.font = UIFont.systemFont(ofSize: 13)

        detailButton.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        detailButton.tintColor = .black.withAlphaComponent(0.6)
        
        cardView.backgroundColor = .white
        
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 15
        
        layer.masksToBounds = false
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.4
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
    }
}
