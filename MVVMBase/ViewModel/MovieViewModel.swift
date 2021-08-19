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
        apiService.getMovie(KEY.apiKey, 1) { (result) in
            switch result {
            case .success(let list):
                self.discoverMovies = list.movies
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    func searchMovies(_ searchText: String,completion: @escaping () -> ()) {
        apiService.searchMovie(KEY.apiKey, searchText) { (result) in
            switch result {
            case .success(let list):
                self.discoverMovies = list.movies
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    func fetchDiscoverMoviesPagination(_ pageNumber: Int,completion: @escaping () -> ()) {
        apiService.getMovie(KEY.apiKey, pageNumber) { (result) in
            switch result {
            case .success(let list):
                self.discoverMovies.append(contentsOf: list.movies)
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    func numberOfRowsInSection(_ section: Int) -> Int {
        if discoverMovies.count != 0 {
            return discoverMovies.count
        }
        return 0
    }
    
    func cellForRowAt (_ indexPath: IndexPath) -> Movie {
        return discoverMovies[indexPath.row]
    }
    func countRow(_ indexPath: IndexPath) -> Int {
        return  discoverMovies.count
    }
}
