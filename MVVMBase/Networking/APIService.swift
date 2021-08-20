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

    func getMovie(_ page: Int,completed: @escaping(Result<MovieModel, Error>) -> Void) {
        let urlString = "\(KEY.apiDiscoveryMoviePath)?api_key=\(KEY.apiKey)&page=\(page)"
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
                        completed(.failure(error))
                        print("Failed to load: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    completed(.failure(error))
                    print("error - > \n  \(error.localizedDescription) \n")
            }
        }
    }
    
    func searchMovie(_ searchText: String,completed: @escaping(Result<MovieModel, Error>) -> Void) {
        let urlString = "\(KEY.apiDiscoverySearchPath)?api_key=\(KEY.apiKey)&query=\(searchText)&sort_by=release_date.desc"
        
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
                        completed(.failure(error))
                    }
                case .failure(let error):
                    print("error - > \n  \(error.localizedDescription) \n")
                    completed(.failure(error))
            }
        }
    }

}
