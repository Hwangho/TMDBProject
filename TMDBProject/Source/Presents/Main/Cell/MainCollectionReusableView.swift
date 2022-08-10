//
//  MainCollectionReusableView.swift
//  TMDBProject
//
//  Created by 송황호 on 2022/08/04.
//

import UIKit

class MainCollectionReusableView: UICollectionReusableView {

    static let identifier = "MainCollectionReusableView"
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    var genres: genreType?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setDesign()
    }
    
    func setData(data: TrendingModel) {
        dateLabel.text = data.release_date
        
        guard let genres = genres else { return }
        genreLabel.text = genres[data.genre_ids[0]]
    }
    
    func setDesign() {
        dateLabel.textColor = .black.withAlphaComponent(0.6)
        dateLabel.text = "12/10/2022"
        dateLabel.font = UIFont.systemFont(ofSize: 13)
        
        genreLabel.textColor = .black
        genreLabel.text = "#Mistery"
        genreLabel.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
}
