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
    func getMovie(apiKey: String, page: Int,completed: @escaping(Result<MovieModel, Error>) -> Void) {
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
}
