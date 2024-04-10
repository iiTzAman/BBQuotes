//
//  FetchQuote.swift
//  BBQuotes
//
//  Created by Aman Giri on 2024-04-08.
//

import Foundation

struct FetchController {
    enum NetworkError : Error {
        case badURL
        case badResponse
    }
    
    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    func fetchQuote(from show: String) async throws -> Quote {
            let quoteUrl = baseURL.appending(path: "quotes/random")
            var quoteComponent = URLComponents(url: quoteUrl, resolvingAgainstBaseURL: true)
            let queryElement = URLQueryItem(name: "production", value: show.replaceSpaceWithPlus)
            
            quoteComponent?.queryItems = [queryElement]
            
            guard let fetchURL = quoteComponent?.url else {
                throw NetworkError.badURL
            }
            print(fetchURL)
            let (data, response) = try await URLSession.shared.data(from: fetchURL)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw NetworkError.badResponse
            }
            
            let quote = try JSONDecoder().decode(Quote.self, from: data)
            return quote
    }
    
    func fetchCharacter(from character: String) async throws -> Character {
        let characterURL = baseURL.appending(path: "characters")
        var characterURLComponent = URLComponents(url: characterURL, resolvingAgainstBaseURL: true)
        let characterURLQueryItem = URLQueryItem(name: "name", value: character.replaceSpaceWithPlus)
        
        characterURLComponent?.queryItems = [characterURLQueryItem]
        
        guard let fetchURL = characterURLComponent?.url else {
            throw NetworkError.badURL
        }
        print(fetchURL)
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedData = try decoder.decode([Character].self, from: data)
        return decodedData[0]
    }
}



