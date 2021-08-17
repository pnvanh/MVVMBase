//
//  ViewController.swift
//  MVVMBase
//
//  Created by Viet Anh on 16/08/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var movieTableView: UITableView!
    private var viewModel = MovieViewModel()
    var pageNumber = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.movieTableView.rowHeight = 150
        
        loadMovide()
        // Do any additional setup after loading the view.
    }
    func loadMovide() {
        viewModel.fetchDiscoverMovies{
            self.movieTableView.dataSource = self
            self.movieTableView.delegate = self
            self.movieTableView.reloadData()
        }
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieCell
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        let vc = (storyboard?.instantiateViewController(identifier: "DetailVC"))! as DetailVC
        vc.movie = movie
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieCell
        let lastItem = viewModel.countRow(indexPath: indexPath) - 1
        if indexPath.row == lastItem {
            print(self.pageNumber)
            self.pageNumber += 1
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            self.movieTableView.tableFooterView = spinner
            self.movieTableView.tableFooterView?.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.viewModel.fetchDiscoverMoviesPagination(pageNumber: self.pageNumber) {
                    self.movieTableView.reloadData()
                }
            }
           
        }
       
    }
}
