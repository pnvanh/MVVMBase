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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }
    
    func setCellWithValuesOf(_ movie:Movie) {
        updateUI(movieTitle: movie.title, movieReleaseDate: movie.releaseDate, movieVote: movie.voteAverage, overview: movie.overview, movieImage: movie.posterPath)
    }
    // Update the UI
    private func updateUI(movieTitle: String?, movieReleaseDate: String?, movieVote: Double?, overview: String?, movieImage: String?) {
        self.movieTitle.text = movieTitle
        self.movieReleaseDate.text = movieReleaseDate?.convertDateFormater(movieReleaseDate)
        guard let rating = movieVote else {return}
        self.movieVote.text = String(rating)
        guard let imageString = movieImage else {return}
        urlString = "https://image.tmdb.org/t/p/w300" + imageString
        self.movieImage.downloadImage(with: urlString)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup() {
        movieCardView.layer.cornerRadius = 15
        movieImage.layer.cornerRadius = 10
        movieCardView.clipsToBounds = true
        movieImage.clipsToBounds = true
    }
    
}
