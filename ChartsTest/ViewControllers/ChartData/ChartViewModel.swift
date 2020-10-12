//
//  ChartViewModel.swift
//  ChartsTest
//
//  Created by Pavel Borisov on 12.10.2020.
//

import Foundation

class ChartViewModel {
    
    // MARK: - Properties
    private let provider = ChartsTestProvider().localProvider
    private let calculator = QuotePerformanceCalculator()
    private let type: ChartType
    
    var title: String? {
        return type.title
    }
    
    init(screen: ChartType) {
        self.type = screen
    }
    
    // MARK: - Public
    func fetchQuotes(successCompletion: @escaping QuotedSymbolsComletion, errorCompletion: @escaping ErrorCompletion) {
        switch type {
		case .weekly:
			provider.request(.quotesWeek) { (result) in
				switch result {
				case .success(let response):
					guard let quotedSymbolsResponse = try? response.map(QuoteSymbolsResponse.self) else {
						let message = Constants.Strings.Errors.weekQuotesFetchError
						errorCompletion(message)
						return
					}
					
					successCompletion(quotedSymbolsResponse.quoteSymbols)
				case .failure(let error):
					errorCompletion(error.localizedDescription)
				}
			}
        case .monthly:
            provider.request(.quotesMonth) { (result) in
                switch result {
                case .success(let response):
                    guard let quotedSymbolsResponse = try? response.map(QuoteSymbolsResponse.self) else {
                        let message = Constants.Strings.Errors.monthQuotesFetchError
                        errorCompletion(message)
                        return
                    }
                    
                    successCompletion(quotedSymbolsResponse.quoteSymbols)
                case .failure(let error):
                    errorCompletion(error.localizedDescription)
                }
            }
        }
    }
}
