//
//  Constants.swift
//  ChartsTest
//
//  Created by Pavel Borisov on 12.10.2020.
//

import Foundation

typealias VoidCompletion = () -> Void
typealias QuotedSymbolsComletion = (([QuoteSymbol]) -> Void)
typealias ErrorCompletion = ((_ message: String) -> Void)

struct Constants {
    static let baseURL: URL = URL(string: "https://www.google.com/")!
    
    struct Strings {
		struct FileTypes {
			static let json = "json"
		}
		
		struct FileNames {
			static let weeklyQuotes = "responseQuotesWeek"
			static let monthlyQuotes = "responseQuotesMonth"
		}
		
		struct ScreenTitles {
			static let dataSelectionScreenTitle = "Select chart"
		}
		
        struct Errors {
            static let weekQuotesFetchError = "Failed to fetch quotes for week. Please try again!"
            static let monthQuotesFetchError = "Failed to fetch quotes for month. Please try again!"
        }
    }
}
