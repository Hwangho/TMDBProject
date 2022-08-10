//
//  TMDBRepository.swift
//  TMDBProject
//
//  Created by 송황호 on 2022/08/10.
//

import Foundation


import Alamofire
import SwiftyJSON


protocol TMDBRpeositoryProtocol {
    func fetchTrendData(media: MediaType, time: TimeWindowType, closure: @escaping ([[TrendingModel]]) -> ())
    func fetchGenre(media: GenreType, closure: @escaping(([Int: String]) -> ()))
    func recomandMovie(id: Int, completionHandler: @escaping([TrendingModel]) -> ())
    func similarMovie(id: Int, completionHandler: @escaping([TrendingModel]) -> ())
    func credits(id: Int, completionHandler: @escaping([CreditsModel]) -> ())
}


class TMDBRpeository: TMDBRpeositoryProtocol {
 
    func fetchTrendData(media: MediaType, time: TimeWindowType, closure: @escaping ([[TrendingModel]]) -> ()) {
        var datas: [TrendingModel] = []
        let url = TMDBRouter.trending(media: media.rawValue, time: time.rawValue).URL
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for data in json["results"].arrayValue {
                    let id = data["id"].intValue
                    let title = data["title"].stringValue.isEmpty ? " " : data["title"].stringValue
                    let overview = data["overview"].stringValue
                    let backgroundImage = TMDBRouter.setPosterImage(image: data["backdrop_path"].stringValue).URL
                    let posterImage = TMDBRouter.setPosterImage(image: data["poster_path"].stringValue).URL
                    let releaseDate = data["release_date"].stringValue.isEmpty ? "0000-00-00" : data["release_date"].stringValue
                    let average = data["vote_average"].doubleValue
                    let genres = data["genre_ids"].rawValue as! [Int]
                    
                    let data = TrendingModel(id: id,
                                             title: title,
                                             overview: overview,
                                             backdrop_path: backgroundImage,
                                             poster_path: posterImage,
                                             release_date: releaseDate,
                                             vote_average: average,
                                             genre_ids: genres)
                    datas.append(data)
                }
                
                /// Sort 해주는 영역
                let changeData = Set(datas.map{$0.release_date}).sorted().map {idx in
                    datas.filter { $0.release_date == idx }
                }
                
                closure(changeData)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchGenre(media: GenreType, closure: @escaping((genreType) -> ())) {
        var genres: [Int: String] = [:]
        let url = TMDBRouter.genre(media: media.rawValue).URL
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for data in json["genres"].arrayValue {
                    let id = data["id"].intValue
                    let name = data["name"].stringValue
                    
                    genres.updateValue(name, forKey: id)
                }
                
                closure(genres)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func recomandMovie(id: Int, completionHandler: @escaping([TrendingModel]) -> ()) {
        var datas: [TrendingModel] = []
        let url = TMDBRouter.recomendMovie(id: id).URL
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for data in json["results"].arrayValue {
                    let id = data["id"].intValue
                    let title = data["title"].stringValue.isEmpty ? " " : data["title"].stringValue
                    let overview = data["overview"].stringValue
                    let backgroundImage = Constant.default.baseURL + data["overview"].stringValue
                    let posterImage = TMDBRouter.setPosterImage(image: data["poster_path"].stringValue).URL
                    let releaseDate = data["release_date"].stringValue.isEmpty ? "0000-00-00" : data["release_date"].stringValue
                    let average = data["vote_average"].doubleValue
                    let genres = data["genre_ids"].rawValue as! [Int]
                    
                    let data = TrendingModel(id: id,
                                             title: title,
                                             overview: overview,
                                             backdrop_path: backgroundImage,
                                             poster_path: posterImage,
                                             release_date: releaseDate,
                                             vote_average: average,
                                             genre_ids: genres)
                    datas.append(data)
                }
                
                completionHandler(datas)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func similarMovie(id: Int, completionHandler: @escaping([TrendingModel]) -> ()) {
        var datas: [TrendingModel] = []
        let url = TMDBRouter.similar(id: id).URL
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for data in json["results"].arrayValue {
                    let id = data["id"].intValue
                    let title = data["title"].stringValue.isEmpty ? " " : data["title"].stringValue
                    let overview = data["overview"].stringValue
                    let backgroundImage = Constant.default.baseURL + data["overview"].stringValue
                    let posterImage = TMDBRouter.setPosterImage(image: data["poster_path"].stringValue).URL
                    let releaseDate = data["release_date"].stringValue.isEmpty ? "0000-00-00" : data["release_date"].stringValue
                    let average = data["vote_average"].doubleValue
                    let genres = data["genre_ids"].rawValue as! [Int]
                    
                    let data = TrendingModel(id: id,
                                             title: title,
                                             overview: overview,
                                             backdrop_path: backgroundImage,
                                             poster_path: posterImage,
                                             release_date: releaseDate,
                                             vote_average: average,
                                             genre_ids: genres)
                    datas.append(data)
                }
                
                completionHandler(datas)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func credits(id: Int, completionHandler: @escaping ([CreditsModel]) -> ()) {
        var datas: [CreditsModel] = []
        let url = TMDBRouter.credits(id: id).URL
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for data in json["cast"].arrayValue {
                    let realName = data["name"].stringValue
                    let castingName = data["character"].stringValue
                    let profilImage = TMDBRouter.setPosterImage(image: data["profile_path"].stringValue).URL
                    
                    let data = CreditsModel(realName: realName,
                                            castingName: castingName,
                                            profileImage: profilImage)
                    
                    datas.append(data)
                }

                completionHandler(datas)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
   
    
}
