//
//  TMDBService.swift
//  TMDBProject
//
//  Created by 송황호 on 2022/08/05.
//

import Foundation

import Alamofire
import SwiftyJSON


protocol TMDBServiceProtocol {
    func fetchAllGenres(complitionHandler: @escaping(genreType) -> ())
    func fetchTrendData(media: MediaType, time: TimeWindowType, complitionHandler: @escaping([[TrendingModel]]) -> ())
    func fetchDetailData(id: Int, completionHandler: @escaping(_ credits: [CreditsModel], _ recomand : [RecomandListModel]) -> ())
}


struct TMDBService: TMDBServiceProtocol {
    
    /// Variable
    let repository: TMDBRpeositoryProtocol = TMDBRpeository()
    

    /// Custom Func
    func fetchAllGenres(complitionHandler: @escaping(genreType) -> ()) {
        var genres: genreType = [:]
        
        repository.fetchGenre(media: .TV) { valueDic in
            for dic in valueDic {
                genres.updateValue(dic.value, forKey: dic.key)
            }
            repository.fetchGenre(media: .movie) { valueDic in
                for dic in valueDic {
                    genres.updateValue(dic.value, forKey: dic.key)
                }
                complitionHandler(genres)
            }
        }
    }
    
    func fetchTrendData(media: MediaType, time: TimeWindowType, complitionHandler: @escaping([[TrendingModel]]) -> ()) {
        repository.fetchTrendData(media: media, time: time) { value in
            complitionHandler(value)
        }
    }
    
    func fetchDetailData(id: Int, completionHandler: @escaping(_ credits: [CreditsModel], _ recomand : [RecomandListModel]) -> ())  {
        var creditList: [CreditsModel] = []
        var recomandlist: [RecomandListModel] = []
        
        repository.credits(id: id) { credits in
            creditList = credits
            repository.recomandMovie(id: id) { recomadList in
                recomandlist.append(RecomandListModel(title: "Recomand Movie", DataList: recomadList))
                repository.similarMovie(id: id) { similarList in
                    recomandlist.append(RecomandListModel(title: "similar Movie", DataList: similarList))
                    completionHandler(creditList, recomandlist)
                }
            }
        }
        
    }

    
}

