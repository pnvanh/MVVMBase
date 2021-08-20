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
            movieLanguage.text = "Language: \( getLanguageString(movie?.originalLanguage ?? "en") ?? "Unknow")"
        }
    }
    @IBOutlet weak var relaseDate: UILabel! {
        didSet {
            relaseDate.text = self.movie?.releaseDate?.convertDateFormater(movie?.releaseDate)
        }
    }
    @IBOutlet weak var rating: UILabel! {
        didSet {
            rating.text = String(self.movie?.voteAverage ?? 1)
        }
    }
    @IBOutlet weak var movieImage: UIImageView!{
        didSet {
            guard let imageString = movie?.posterPath else { return }
            let urlString = KEY.imagePath + imageString
            self.movieImage.downloadImage(urlString)
        }
    }
    @IBOutlet weak var cardTag: UIView!
    
    struct Define {
        static let cardRadius:CGFloat = 15
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        cardTag.layer.cornerRadius = Define.cardRadius
        cardTag.clipsToBounds = true
    }
    
    @IBAction func bookMovie(_ sender: Any) {
        if let requestUrl = URL(string: KEY.openWatchMovie) {
            UIApplication.shared.open(requestUrl, options: [:], completionHandler: nil)
        }
    }
}
