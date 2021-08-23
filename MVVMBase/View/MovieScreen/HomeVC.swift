//
//  ViewController.swift
//  MVVMBase
//
//  Created by Viet Anh on 16/08/2021.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet fileprivate weak var movieTableView: UITableView!
    
    private var viewModel = MovieViewModel()
    private let searchController = UISearchController(searchResultsController: nil)
    private let refreshControl = UIRefreshControl()
    
    struct Define {
        static let movieRowHeight:CGFloat = 250
        static let paginationHeight:CGFloat = 44
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMovieTableView()
        setupPullRefresh()
        setupSearchController()
        loadMovide()
    }
    func setupMovieTableView(){
        self.movieTableView.registerNib(cellName: MovieCell.className)
        self.movieTableView.estimatedRowHeight = Define.movieRowHeight
        self.movieTableView.dataSource = self
        self.movieTableView.delegate = self
    }
    
    func setupPullRefresh() {
        self.title = "Movie"
        //pull to refresh
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.movieTableView.addSubview(refreshControl)
    }
    
    func setupSearchController(){
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
    
    func loadMovide() {
        viewModel.fetchDiscoverMovies{error in
            self.movieTableView.reloadData()
        }
    }
    
    @objc func refresh(refreshControl: UIRefreshControl) {
        loadMovide()
        refreshControl.endRefreshing()
    }
    
    func gotoDetailPage(_ movie: Movie) {
        let vc = DetailVC.loadFromStoryboard()
        vc.movie = movie
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: — Extension TableViewDelegate & TableViewDatasource
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: MovieCell.self, for: indexPath)
        let movie = viewModel.getCellForRow(indexPath)
        cell.movie = movie
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.getCellForRow(indexPath)
        gotoDetailPage(movie)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = viewModel.countRow(indexPath) - 1
        if indexPath.row == lastItem {
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: Define.paginationHeight)
            self.movieTableView.tableFooterView = spinner
            loadPageView()
        }
    }
    
    func loadPageView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.viewModel.fetchDiscoverMoviesPagination { error in
                if error != nil {
                    self.showMessage("Error", "\(error?.localizedDescription ?? "Unknow error")")
                }else{
                    self.movieTableView.reloadData()
                }
            }
        }
    }
    
}

//MARK: — Extension SearchResult
extension HomeVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        viewModel.searchMovies(searchText) {_ in
            self.movieTableView.reloadData()
        }
    }
}
