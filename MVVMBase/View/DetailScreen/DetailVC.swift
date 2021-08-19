//
//  DetailVC.swift
//  MVVMBase
//
//  Created by Viet Anh on 17/08/2021.
//

import UIKit

class DetailVC: UIViewController {
    
    var movie: Movie?
    
    @IBOutlet weak var movieTitle: UILabel! {
        didSet {
            movieTitle.text = movie?.title
        }
    }
    @IBOutlet weak var descriptonMovie: UILabel! {
        didSet {
            descriptonMovie.text = movie?.overview
        }
    }
    @IBOutlet weak var movieLanguage: UILabel! {
        didSet {
            movieLanguage.text = "Language: \( LanguageHelper.getLanguageString(self.movie!.originalLanguage) ?? "")"
        }
    }
    @IBOutlet weak var relaseDate: UILabel! {
        didSet {
            relaseDate.text = self.movie!.releaseDate.convertDateFormater(movie?.releaseDate)
        }
    }
    @IBOutlet weak var rating: UILabel! {
        didSet {
            rating.text = String(self.movie!.voteAverage)
        }
    }
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var cardTag: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI() {
        cardTag.layer.cornerRadius = 15
        cardTag.clipsToBounds = true

        guard let imageString = movie?.posterPath else { return }
        let urlString = "https://image.tmdb.org/t/p/w300" + imageString
        self.movieImage.downloadImage(urlString)
    }
    @IBAction func bookMovie(_ sender: Any) {
        if let requestUrl = URL(string: "https://www.cathaycineplexes.com.sg/movies/") {
            UIApplication.shared.open(requestUrl, options: [:], completionHandler: nil)
        }
    }
}
