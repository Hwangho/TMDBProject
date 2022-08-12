//
//  BaseTableViewCell.swift
//  TMDBProject
//
//  Created by 송황호 on 2022/08/11.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = Color.BaseColor.backgroundColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
