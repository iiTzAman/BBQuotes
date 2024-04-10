//
//  ViewController.swift
//  BBQuotes
//
//  Created by Aman Giri on 2024-04-08.
//

import Foundation

@MainActor
class ViewModel: ObservableObject {
    enum Status {
        case notStarted
        case fetching
        case success(data: (quote: Quote, character: Character))
        case failed(error: Error)
    }
    
    @Published private(set) var status: Status = .notStarted
    private let controller: FetchController
    
    init(controller: FetchController) {
        self.controller = controller
    }
    
    func getData(for show: String) async {
        status = .fetching
        print(status)
        do{
            let quote = try await controller.fetchQuote(from: show)
            let character = try await controller.fetchCharacter(from: quote.character)
            status = .success(data: (quote: quote, character: character))
            print(status)
        } catch {
            status = .failed(error: error)
            print(status)
        }
    }
    
}
