//
//  String+Extensions.swift
//  MVVMBase
//
//  Created by Viet Anh on 20/08/2021.
//

import Foundation

func getLanguageString(_ code:String) -> String? {
    let locale: NSLocale? = NSLocale(localeIdentifier: "en")
    return locale?.displayName(forKey: .identifier, value: code)
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
