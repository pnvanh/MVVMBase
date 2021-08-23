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
    private var pageNumber = 1
    
    func fetchDiscoverMovies(completion: @escaping (_ error: Error?) -> ()) {
        apiService.getMovie(1) { (result) in
            switch result {
            case .success(let list):
                self.discoverMovies = list.movies
                completion(nil)
            case .failure(let error):
                print("Error processing json data: \(error)")
                completion(error)
            }
        }
    }
    
    func searchMovies(_ searchText: String,completion: @escaping (_ error: Error?) -> ()) {
        apiService.searchMovie(searchText) { (result) in
            switch result {
            case .success(let list):
                self.discoverMovies = list.movies
                completion(nil)
            case .failure(let error):
                print("Error processing json data: \(error)")
                completion(error)
            }
        }
    }
    
    func fetchDiscoverMoviesPagination(completion: @escaping (_ error: Error?) -> ()) {
        self.pageNumber += 1
        apiService.getMovie(pageNumber) { (result) in
            switch result {
            case .success(let list):
                self.discoverMovies.append(contentsOf: list.movies)
                completion(nil)
            case .failure(let error):
                print("Error processing json data: \(error)")
                completion(error)
            }
        }
        
    }
    
    func getNumberOfRows(_ section: Int) -> Int {
        if discoverMovies.count != 0 {
            return discoverMovies.count
        }
        return 0
    }
    
    func getCellForRow (_ indexPath: IndexPath) -> Movie {
        return discoverMovies[indexPath.row]
    }
    
    func countRow(_ indexPath: IndexPath) -> Int {
        return  discoverMovies.count
    }
}
