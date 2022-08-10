//
//  TMDBRouter.swift
//  TMDBProject
//
//  Created by 송황호 on 2022/08/04.
//

import Foundation

enum TMDBRouter {
    case trending(media: String, time: String)
    case setPosterImage(size: PosterSizeType = .size500, image: String)
    case genre(media: String)
    case recomendMovie(id: Int)
    case similar(id: Int)
    case credits(id: Int)
}

extension TMDBRouter {
    
    var URL: String {
        switch self {
        case .trending(let media, let time):
            return "\(Constant.default.baseURL)/trending/\(media)/\(time)?api_key=\(Storage.TMDB_api_key)"
            
        case .setPosterImage(let size, let image):
            return "\(Constant.default.getImageURL)\(size.rawValue)\(image)"
            
        case .genre(let media):
            return "\(Constant.default.baseURL)/genre/\(media)/list?api_key=\(Storage.TMDB_api_key)&language=\(Constant.default.language.rawValue)"
            
        case .recomendMovie(let id):
            return "\(Constant.default.baseURL)/movie/\(id)/recommendations?api_key=\(Storage.TMDB_api_key)&language=\(Constant.default.language.rawValue)&page=1"
            
        case .similar(let id):
            return "\(Constant.default.baseURL)/movie/\(id)/similar?api_key=\(Storage.TMDB_api_key)&language=\(Constant.default.language.rawValue)&page=1"
            
        case .credits(let id):
            return "\(Constant.default.baseURL)/movie/\(id)/credits?api_key=\(Storage.TMDB_api_key)&language=\(Constant.default.language.rawValue)"
            
        }
    }
    
}
