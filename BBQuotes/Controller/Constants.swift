//
//  Constants.swift
//  BBQuotes
//
//  Created by Aman Giri on 2024-04-08.
//

import Foundation

extension String {
    var replaceSpaceWithPlus: String {
        self.replacingOccurrences(of: " ", with: "+")
    }
}
