//
//  DateExtension.swift
//  brewingdiary
//
//  Created by Stefan Zapf on 19.01.21.
//

import Foundation

extension Date {
    func short() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: self)
    }
}
