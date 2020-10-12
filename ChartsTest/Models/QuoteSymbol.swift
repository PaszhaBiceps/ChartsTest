//
//  QuoteSymbol.swift
//  ChartsTest
//
//  Created by Pavel Borisov on 12.10.2020.
//

import Foundation

struct QuoteSymbol: Codable {
	let symbol: String
	let timestamps, volumes: [Int]
	let opens, closures, highs, lows: [Double]
}
