//
//  MainDetailOverViewTableViewCell.swift
//  TMDBProject
//
//  Created by 송황호 on 2022/08/07.
//

import UIKit

class MainDetailOverViewTableViewCell: UITableViewCell {

    @IBOutlet weak var overLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(content: String) {
        overLabel.text = content
    }

    func setDesign() {
        overLabel.textAlignment = .center
    }
    
}
