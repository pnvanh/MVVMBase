//
//  LanguageHelper.swift
//  MVVMBase
//
//  Created by Viet Anh on 19/08/2021.
//

import Foundation

struct LanguageHelper {
    static func getLanguageString(_ code:String) -> String? {
        let locale: NSLocale? = NSLocale(localeIdentifier: "en")
        return locale?.displayName(forKey: .identifier, value: code)
    }
}
