//
//  MovieCell.swift
//  MVVMBase
//
//  Created by Viet Anh on 16/08/2021.
//

import UIKit

class MovieCell: UITableViewCell {


    @IBOutlet fileprivate weak var overview: UILabel!
    @IBOutlet fileprivate weak var movieCardView: UIView!
    @IBOutlet fileprivate weak var movieVote: UILabel!
    @IBOutlet fileprivate weak var movieReleaseDate: UILabel!
    @IBOutlet fileprivate weak var movieTitle: UILabel!
    @IBOutlet fileprivate weak var movieImage: UIImageView!
    
    private var urlString: String = ""
    
    var movie: Movie? {
        didSet {
            guard let movie = self.movie else { return }
            self.movieTitle.text = movie.title
            self.movieReleaseDate.text = movie.releaseDate?.convertDateFormater(movie.releaseDate)
            self.movieVote.text = "\(movie.voteAverage ?? 0)"
            guard let imageString = movie.posterPath else {return}
            urlString = KEY.imagePath + imageString
            self.movieImage.downloadImage(urlString)
            self.overview.text = movie.overview
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup() {
        movieCardView.layer.cornerRadius = 15
        movieImage.layer.cornerRadius = 10
        movieCardView.clipsToBounds = true
        movieImage.clipsToBounds = true
    }
    
}
