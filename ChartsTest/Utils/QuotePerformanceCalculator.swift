//
//  QuotePerformanceCalculator.swift
//  ChartsTest
//
//  Created by Pavel Borisov on 12.10.2020.
//

import Foundation

class QuotePerformanceCalculator {
    
    typealias QuotePerformance = (timestamp: Int, performance: Double)
    
    func calculatePerformance(for quote: QuoteSymbol) -> [QuotePerformance] {
		guard let basePrice = quote.opens.first else { return [] }
        return zip(quote.timestamps, quote.opens).map { data -> QuotePerformance in
			let performanceValue = 100 * data.1 / basePrice - 100
			return (data.0, performanceValue)
		}
    }
    
}
