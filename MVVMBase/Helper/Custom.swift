//
//  Custom.swift
//  MVVMBase
//
//  Created by Viet Anh on 17/08/2021.
//
import UIKit
import Kingfisher
extension UIImageView {
    func loadImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }

        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    func makeRound() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func downloadImage(`with` urlString : String){
        let url = URL(string: urlString)
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
extension String {
    // MARK: - Convert date format
    func convertDateFormater(_ date: String?) -> String {
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let originalDate = date {
            if let newDate = dateFormatter.date(from: originalDate) {
                dateFormatter.dateFormat = "dd-MM-yyyy"
                fixDate = dateFormatter.string(from: newDate)
            }
        }
        return fixDate
    }

}
struct LanguageHelper {
    static func getLanguageString(code:String) -> String? {
        let locale: NSLocale? = NSLocale(localeIdentifier: "en")
        return locale?.displayName(forKey: .identifier, value: code)
    }
}
