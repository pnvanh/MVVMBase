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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.movieTableView.rowHeight = 150
        loadMovide()
        // Do any additional setup after loading the view.
    }
    func loadMovide() {
        viewModel.fetchDiscoverMovies {
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
 
}
