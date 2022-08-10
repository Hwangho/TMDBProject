//
//  NetFlixViewController.swift
//  TMDBProject
//
//  Created by 송황호 on 2022/08/10.
//

import UIKit

import Kingfisher


enum MovieDetailType: CaseIterable {
    case poster
    case overview
    case cast
    case recomand
    case similar
}


class NetFlixViewController: UIViewController {
    
    /// IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    
    /// Variable
    var service: TMDBServiceProtocol  = TMDBService()
    
    var creditList: [CreditsModel] = []
    
    var recomadData: [RecomandListModel] = []
    
    var overView: String?
    
    var backgroundPosterImage: String?
    
    var movieTitle: String?
    
    var posterImage: String?
    
    var id: Int {
        get {
            return self.id
        }
        set {
            service.fetchDetailData(id: newValue) { creditList, recomandList in
                self.creditList = creditList
                self.recomadData = recomandList
//                dump(self.recomadData)
                self.tableView.reloadData()
            }
        }
    }
    
    /// Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: MainDetailPosterTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MainDetailPosterTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: MainDetailOverViewTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MainDetailOverViewTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: MainDetailCastTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MainDetailCastTableViewCell.reuseIdentifier)
    }
}


// MARK: UITableView DataSource

extension NetFlixViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MovieDetailType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let setting = MovieDetailType.allCases[section]
        
        switch setting {
        case .poster, .overview, .recomand, .similar:
            return 1
            
        case .cast:
            return creditList.isEmpty ? 0 : 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let setting = MovieDetailType.allCases[indexPath.section]
        
        switch setting {
        case .poster:
            guard let posterCell = tableView.dequeueReusableCell(withIdentifier: MainDetailPosterTableViewCell.reuseIdentifier, for: indexPath) as? MainDetailPosterTableViewCell else { return UITableViewCell() }
            
            posterCell.movieTitleLabel.text = movieTitle
            
            let backurl = URL(string: backgroundPosterImage!)
            posterCell.backgroundImage.kf.setImage(with: backurl)
            
            let posterurl = URL(string: posterImage!)
            posterCell.poseterImage.kf.setImage(with: posterurl)
            return posterCell
            
        case .overview:
            guard let overViewCell = tableView.dequeueReusableCell(withIdentifier: MainDetailOverViewTableViewCell.reuseIdentifier, for: indexPath) as? MainDetailOverViewTableViewCell else { return UITableViewCell() }
            
            overViewCell.setData(content: overView!)
            return overViewCell
            
        case .cast:
            guard let castCell = tableView.dequeueReusableCell(withIdentifier: MainDetailCastTableViewCell.reuseIdentifier, for: indexPath) as? MainDetailCastTableViewCell else { return UITableViewCell() }
            
            castCell.setData(credit: creditList[indexPath.item])
            return castCell
            
        case .recomand:
            guard let netflixCell = tableView.dequeueReusableCell(withIdentifier: NetflixTableViewCell.reuseIdentifier, for: indexPath) as? NetflixTableViewCell else { return UITableViewCell() }
            
            netflixCell.collectionView.reloadData()
            netflixCell.collectionView.dataSource = self
            netflixCell.collectionView.delegate = self
            netflixCell.collectionView.collectionViewLayout = collectionViewLayout()
            netflixCell.collectionView.showsHorizontalScrollIndicator = false
            netflixCell.collectionView.tag = 0
            netflixCell.collectionView.register(UINib(nibName: NetFlixCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: NetFlixCollectionViewCell.reuseIdentifier)
            
            
            return netflixCell
            
        case .similar:
            guard let netflixCell = tableView.dequeueReusableCell(withIdentifier: NetflixTableViewCell.reuseIdentifier, for: indexPath) as? NetflixTableViewCell else { return UITableViewCell() }
            
            netflixCell.collectionView.reloadData()
            netflixCell.collectionView.dataSource = self
            netflixCell.collectionView.delegate = self
            netflixCell.collectionView.collectionViewLayout = collectionViewLayout()
            netflixCell.collectionView.showsHorizontalScrollIndicator = false
            netflixCell.collectionView.tag = 1
            netflixCell.collectionView.register(UINib(nibName: NetFlixCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: NetFlixCollectionViewCell.reuseIdentifier)
            
            return netflixCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let setting = MovieDetailType.allCases[indexPath.section]
        
        switch setting {
            
        case .poster:
            return CGFloat(200)
            
        case .overview:
            return CGFloat(100)
            
        case .cast:
            return CGFloat(80)
            
        case .recomand, .similar:
            return CGFloat(200)
        }
    }
    
    // tableView header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let setting = MovieDetailType.allCases[section]
        
        switch setting {
        case .overview:
            return "OverView"
            
        case .cast:
            return "Cast"

        case .recomand:
            return  recomadData.isEmpty ? "" : recomadData[0].title
            
        case .similar:
            return  recomadData.isEmpty ? "" : recomadData[1].title
            
        default:
            return nil
        }
    }
    
}


// MARK: UICollectionView DataSource

extension NetFlixViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recomadData.isEmpty ? 0 : recomadData[collectionView.tag].DataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NetFlixCollectionViewCell.reuseIdentifier, for: indexPath) as? NetFlixCollectionViewCell else { return UICollectionViewCell() }
        
        let url = URL(string: recomadData[collectionView.tag].DataList[indexPath.row].poster_path!)
        cell.posterImage.kf.setImage(with: url)
        return cell
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 200)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 0)
        return layout
    }
    
    
}
