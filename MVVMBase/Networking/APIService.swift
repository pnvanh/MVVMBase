//
//  APIService.swift
//  MVVMBase
//
//  Created by Viet Anh on 16/08/2021.
//

import Foundation
import Alamofire

class APIService {
    static let shared = APIService()
    var session = Session()
    let configuration = URLSessionConfiguration.default
    func getMovie(_ apiKey: String,_ page: Int,completed: @escaping(Result<MovieModel, Error>) -> Void) {
        let urlString = "http://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&page=\(page)"
        guard let url = URL(string: urlString) else {return}
        session.request(url, method: .get).validate().responseJSON { response in
            switch (response.result) {
                case .success:
                    do {
                        let json = try JSONDecoder().decode(MovieModel.self, from: response.data!)
                        DispatchQueue.main.async {
                            completed(.success(json))
                        }
                    }catch(let error){
                        print("Failed to load: \(error.localizedDescription)")
                    }
                    
                case .failure(let error):
                    print("error - > \n  \(error.localizedDescription) \n")
            }
        }
    }
    func searchMovie(_ apiKey: String,_ searchText: String,completed: @escaping(Result<MovieModel, Error>) -> Void) {
        let urlString = "http://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(searchText)&sort_by=release_date.desc"
        guard let url = URL(string: urlString) else {return}
        session.request(url, method: .get).validate().responseJSON { response in
            switch (response.result) {
                case .success:
                    do {
                        let json = try JSONDecoder().decode(MovieModel.self, from: response.data!)
                        DispatchQueue.main.async {
                            completed(.success(json))
                        }
                    }catch(let error){
                        print("Failed to load: \(error.localizedDescription)")
                    }
                    
                case .failure(let error):
                    print("error - > \n  \(error.localizedDescription) \n")
            }
        }
    }

}
