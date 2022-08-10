//
//  ReusableViewProtocol.swift
//  TMDBProject
//
//  Created by 송황호 on 2022/08/10.
//

import Foundation
import UIKit

protocol ReuseableViewProtocol {
    static var reuseIdentifier: String { get }
}


extension UIViewController: ReuseableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReuseableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
