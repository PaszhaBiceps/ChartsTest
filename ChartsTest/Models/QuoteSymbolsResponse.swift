//
//  QuoteSymbolsResponse.swift
//  ChartsTest
//
//  Created by Pavel Borisov on 12.10.2020.
//

import Foundation

// MARK: - Welcome
struct QuoteSymbolsResponse: Decodable {
    let quoteSymbols: [QuoteSymbol]
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case content
        case status
    }
    
    enum QuoteSymbolsCodingKeys: String, CodingKey {
        case quoteSymbols
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let quoteSymbolsContainer = try container.nestedContainer(keyedBy: QuoteSymbolsCodingKeys.self, forKey: .content)
        
        status = try container.decode(String.self, forKey: .status)
        quoteSymbols = try quoteSymbolsContainer.decode([QuoteSymbol].self, forKey: .quoteSymbols)
    }
}
