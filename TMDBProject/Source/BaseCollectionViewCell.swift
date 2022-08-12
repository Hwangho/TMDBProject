//
//  BaseCollectionViewCell.swift
//  TMDBProject
//
//  Created by 송황호 on 2022/08/11.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = Color.BaseColor.backgroundColor
    }
}
