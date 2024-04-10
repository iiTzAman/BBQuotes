//
//  Character.swift
//  BBQuotes
//
//  Created by Aman Giri on 2024-04-08.
//

import Foundation

struct Character: Codable {
    let name: String
    let birthday: String
    let occupations: [String]
    let images: [URL]
    let aliases: [String]
    let portrayedBy: String
}
