//
//  MovieCell.swift
//  MVVMBase
//
//  Created by Viet Anh on 16/08/2021.
//

import UIKit

class MovieCell: UITableViewCell {


    @IBOutlet weak var movieCardView: UIView!
    @IBOutlet weak var movieVote: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    private var urlString: String = ""
    var movie: Movie? {
        didSet {
            guard let movie = self.movie else { return }
            self.movieTitle.text = movie.title
            self.movieReleaseDate.text = movie.releaseDate.convertDateFormater(movie.releaseDate)
            self.movieVote.text = String(movie.voteAverage)
            guard let imageString = movie.posterPath else {return}
            urlString = KEY.imagePath + imageString
            self.movieImage.downloadImage(urlString)
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
