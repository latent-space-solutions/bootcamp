//
//  FileManager.swift
//  brewingdiary
//
//  Created by Stefan Zapf on 19.01.21.
//

import Foundation

extension FileManager {
    static var documentsUrl: URL {
        `default`.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
