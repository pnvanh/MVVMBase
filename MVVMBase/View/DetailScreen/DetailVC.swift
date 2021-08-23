//
//  DetailVC.swift
//  MVVMBase
//
//  Created by Viet Anh on 17/08/2021.
//

import UIKit

class DetailVC: UIViewController {
    
    var movie: Movie?
    
    @IBOutlet fileprivate weak var movieTitle: UILabel!
    @IBOutlet fileprivate weak var descriptonMovie: UILabel!
    @IBOutlet fileprivate weak var movieLanguage: UILabel!
    @IBOutlet fileprivate weak var relaseDate: UILabel!
    @IBOutlet fileprivate weak var rating: UILabel!
    @IBOutlet fileprivate weak var movieImage: UIImageView!
    @IBOutlet fileprivate weak var cardTag: UIView!
    
    struct Define {
        static let cardRadius:CGFloat = 15
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        binding()
    }
    
    func setupUI() {
        self.navigationController?.navigationBar.tintColor = .white
        cardTag.layer.cornerRadius = Define.cardRadius
        cardTag.clipsToBounds = true
    }
    
    func binding(){
        guard let imageString = movie?.posterPath else { return }
        let urlString = KEY.imagePath + imageString
        movieImage.downloadImage(urlString)
        rating.text = String(movie?.voteAverage ?? 0)
        relaseDate.text = movie?.releaseDate?.convertDateFormater(movie?.releaseDate)
        movieLanguage.text = "Language: \(getLanguageString(movie?.originalLanguage ?? "") ?? "Unknow")"
        descriptonMovie.text = movie?.overview
        movieTitle.text = movie?.title
    }
    
    //MARK: — Action
    @IBAction func bookMovie(_ sender: Any) {
        if let requestUrl = URL(string: KEY.openWatchMovie) {
            UIApplication.shared.open(requestUrl, options: [:], completionHandler: nil)
        }
    }
}
