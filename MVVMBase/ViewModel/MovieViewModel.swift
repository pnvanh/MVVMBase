//
//  MovieViewModel.swift
//  MVVMBase
//
//  Created by Viet Anh on 16/08/2021.
//

import Foundation


class MovieViewModel {
    
    private var apiService = APIService()
    private var discoverMovies = [Movie]()
    
    func fetchDiscoverMovies(completion: @escaping () -> ()) {
        apiService.getMovie(apiKey: "328c283cd27bd1877d9080ccb1604c91", page: 1) { (result) in
            switch result {
            case .success(let list):
                self.discoverMovies = list.movies
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    func numberOfRowsInSection(section: Int) -> Int {
        if discoverMovies.count != 0 {
            return discoverMovies.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Movie {
        return discoverMovies[indexPath.row]
    }
}
