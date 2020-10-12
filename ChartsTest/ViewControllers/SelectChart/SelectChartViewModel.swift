//
//  SelectChartViewModel.swift
//  ChartsTest
//
//  Created by Pavel Borisov on 12.10.2020.
//

import Foundation

enum ChartType: CaseIterable {
	case weekly
	case monthly
	
	var title: String {
		switch self {
		case .weekly:
			return "Weekly"
		case .monthly:
			return "Montly"
		}
	}
}

class SelectChartViewModel {
	
	var screenTitle = Constants.Strings.ScreenTitles.dataSelectionScreenTitle
	var items: [ChartType]
	
	init() {
		items = ChartType.allCases
	}
}
