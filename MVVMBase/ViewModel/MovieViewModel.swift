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
        apiService.getMovie(apiKey: KEY.apiKey, page: 1) { (result) in
            switch result {
            case .success(let list):
                self.discoverMovies = list.movies
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    func fetchDiscoverMoviesPagination(pageNumber: Int,completion: @escaping () -> ()) {
        apiService.getMovie(apiKey: KEY.apiKey, page: pageNumber) { (result) in
            switch result {
            case .success(let list):
                self.discoverMovies.append(contentsOf: list.movies)
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
    func countRow(indexPath: IndexPath) -> Int {
        return  discoverMovies.count
    }
}
