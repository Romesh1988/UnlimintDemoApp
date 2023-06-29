//
//  JokePresenter.swift
//  UnlimintDemo
//
//  Created by Romesh Bansal on 29/06/23.
//

import Foundation


protocol JokeView: NSObjectProtocol {
    func addJoke(joke: Joke)
    func apiErrorDescription(error: String)
}

class JokePresenter {
    private let apiService: APIService
    weak private var jokeView: JokeView?
    
    init(service: APIService) {
        self.apiService = service
    }
    
    func attachView(view: JokeView) {
        jokeView = view
    }
    
    func detachView() {
        jokeView = nil
    }
    
    func getJoke() {
        self.apiService.callAPIGetJokes { [weak self] joke in
            guard let ws = self else { return }
            ws.jokeView?.addJoke(joke: joke)
        } onFailure: { [weak self] errorMessage in
            guard let ws = self else { return }
            ws.jokeView?.apiErrorDescription(error: errorMessage)

        }
    }
}
