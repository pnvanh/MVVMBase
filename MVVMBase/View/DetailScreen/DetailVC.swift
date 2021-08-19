//
//  DetailVC.swift
//  MVVMBase
//
//  Created by Viet Anh on 17/08/2021.
//

import UIKit

class DetailVC: UIViewController {

    
    @IBOutlet weak var descriptonMovie: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    @IBOutlet weak var relaseDate: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var cardTag: UIView!
    var movie: Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    func setupUI() {
        cardTag.layer.cornerRadius = 15
        cardTag.clipsToBounds = true
        movieTitle.text = self.movie?.title
        rating.text = String(self.movie!.voteAverage)
        relaseDate.text = self.movie!.releaseDate.convertDateFormater(movie?.releaseDate)
        descriptonMovie.text = self.movie?.overview
        movieLanguage.text = "Language: \( LanguageHelper.getLanguageString(self.movie!.originalLanguage) ?? "")"
        guard let imageString = movie?.posterPath else {return}
        let urlString = "https://image.tmdb.org/t/p/w300" + imageString
        self.movieImage.downloadImage(urlString)
    }
    @IBAction func bookMovie(_ sender: Any) {
        if let requestUrl = URL(string: "https://www.cathaycineplexes.com.sg/movies/") {
            UIApplication.shared.open(requestUrl, options: [:], completionHandler: nil)
        }
    }
}
