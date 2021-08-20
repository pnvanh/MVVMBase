//
//  NSObject+Extensions.swift
//  MVVMBase
//
//  Created by Viet Anh on 20/08/2021.
//

import Foundation

extension NSObject {

    @objc var className: String {
        return String(describing: type(of: self))
    }

    @objc class var className: String {
        return String(describing: self)
    }
}
