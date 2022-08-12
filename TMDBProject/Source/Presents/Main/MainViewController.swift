//
//  MainViewController.swift
//  TMDBProject
//
//  Created by 송황호 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON


typealias genreType = [Int: String]


class MainViewController: BaseViewController {
    
    /// Outlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    /// variable
    var media: MediaType = .movie
    
    var time: TimeWindowType = .day
    
    var service: TMDBServiceProtocol  = TMDBService()
    
    var genres: genreType = [:]
    
    var datas: [[TrendingModel]] = []
    
    
    /// Life Cycle
    override func viewDidLoad() {        
        super.viewDidLoad()

        collectionView.collectionViewLayout = collectionViewLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: MainCollectionViewCell.identifier, bundle: nibBundle), forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: MainCollectionReusableView.identifier, bundle: nibBundle), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainCollectionReusableView.identifier)
        
        requestGenreData()
    }
    
    
    /// Custom Func
    func requestGenreData() {
        service.fetchAllGenres { [weak self]  genres in
            for genreDic in genres {
                self?.genres.updateValue(genreDic.value, forKey: genreDic.key)
            }
            self?.requestTMDBData(mediaType: self!.media, timeWindow: self!.time)
        }
    }
    
    func requestTMDBData(mediaType media: MediaType, timeWindow time: TimeWindowType) {
        service.fetchTrendData(media: media, time: time) { [weak self] datas in
            self?.datas = datas
            self?.collectionView.reloadData()
        }
    }
       
}


// MARK: CollectionViewDataSource

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        cell.setData(data :datas[indexPath.section][indexPath.row])
        
        return cell
    }
    
    
    /// header
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainCollectionReusableView.identifier, for: indexPath) as? MainCollectionReusableView else { return UICollectionReusableView() }
            header.setData(data: datas[indexPath.section][0])
            header.genres = genres
            
            return header
        default:
            assert(false,"")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        
        return CGSize(width: width, height: 60)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: NetFlixViewController.reuseIdentifier) as? NetFlixViewController else { return }
        
        vc.id = datas[indexPath.section][indexPath.item].id
        vc.overView = datas[indexPath.section][indexPath.item].overview
        vc.backgroundPosterImage = datas[indexPath.section][indexPath.item].backdrop_path
        vc.posterImage = datas[indexPath.section][indexPath.item].poster_path
        vc.movieTitle = datas[indexPath.section][indexPath.item].title
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: CollectionView FlowLayout

extension MainViewController {
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let space: CGFloat = 20
        let width = UIScreen.main.bounds.width - (space * 2)
        layout.itemSize = CGSize(width: width, height: width*20/21)
        layout.sectionInset = UIEdgeInsets(top: 5, left: space, bottom: space, right: space)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = space
        layout.minimumLineSpacing = space
        
        return layout
    }
}
