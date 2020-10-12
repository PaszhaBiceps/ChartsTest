//
//  ChartViewController.swift
//  ChartsTest
//
//  Created by Pavel Borisov on 12.10.2020.
//

import UIKit
import Charts

class ChartViewController: BaseViewController, ChartViewDelegate {
    
    // MARK: - Outlets & Properties
    @IBOutlet private weak var lineChartView: LineChartView!
    @IBOutlet private weak var AAPLCandleStickChartView: CandleStickChartView!
    @IBOutlet private weak var MSFTCandleStickChartView: CandleStickChartView!
    @IBOutlet private weak var SPYCandleStickChartView: CandleStickChartView!
    
    var viewModel: ChartViewModel!
	private var candlestickCharts:[CandleStickChartView] = []
	
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        baseSetup()
        fetchQuotes()
    }
    
	// MARK: - Private
	private func baseSetup() {
		navigationItem.title = viewModel?.title
		candlestickCharts = [AAPLCandleStickChartView, MSFTCandleStickChartView, SPYCandleStickChartView]
		setupChartsUI()
	}
	
	private func setupChartsUI() {
		configureLineChartView(lineChartView)
		candlestickCharts.forEach { configureCandleStickChartView($0) }
	}
	
    private func fetchQuotes() {
        viewModel.fetchQuotes(successCompletion: { [weak self] (quotes) in
            guard let `self` = self else { return }
			self.setupChartsData(with: quotes)
		}) {[weak self] errorMessage in
			self?.showOkAlert(of: .error,
							  with: errorMessage)
        }
    }
	
	private func setupChartsData(with quotes: [QuoteSymbol]) {
		// Line chart
		configureLineChartData(for: lineChartView, with: quotes)
		
		// Candlestick charts
		// In this case we know that number of carts == number of quotes
		// Would be different with dynamic data
		for (index, chartView) in candlestickCharts.enumerated() {
			configureCandleStickChartData(for: chartView, quote: quotes[index])
		}
	}
	
	/**
	Line chart UI
	*/
	private func configureLineChartView(_ chartView: LineChartView) {
		chartView.delegate = self
		chartView.chartDescription?.enabled = false
		chartView.leftAxis.enabled = false
		chartView.rightAxis.drawAxisLineEnabled = false
		chartView.xAxis.drawAxisLineEnabled = false
		chartView.drawBordersEnabled = false
		chartView.setScaleEnabled(true)

		let legend = chartView.legend
		legend.horizontalAlignment = .right
		legend.verticalAlignment = .top
		legend.orientation = .vertical
		legend.drawInside = false
	}
    
	/**
	Candlestick chart UI
	*/
    private func configureCandleStickChartView(_ chartView: CandleStickChartView) {
        chartView.delegate = self
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.maxVisibleCount = 500
        chartView.pinchZoomEnabled = true
        
        chartView.legend.horizontalAlignment = .right
        chartView.legend.verticalAlignment = .top
        chartView.legend.orientation = .vertical
        chartView.legend.drawInside = false
        chartView.rightAxis.enabled = false
        chartView.xAxis.labelPosition = .bottom
    }
    
	/**
	Line chart data setup
	*/
    func configureLineChartData(for chartView: LineChartView, with qoutes: [QuoteSymbol]) {
		
        let calculator = QuotePerformanceCalculator()
                
        let colors = ChartColorTemplates.material()
        let dataSets = qoutes.enumerated().map { (index, quote) -> LineChartDataSet in
            let performance = calculator.calculatePerformance(for: quote)
            let dataEntry = performance.map({ ChartDataEntry(x: Double($0.timestamp), y: $0.performance) })
                       
            let set = LineChartDataSet(entries: dataEntry, label: quote.symbol)
            set.lineWidth = 2.5
            set.circleRadius = 4
            set.circleHoleRadius = 2
            let color = colors[index % colors.count]
            set.setColor(color)
            set.setCircleColor(color)
            
            return set
        }
        
        let data = LineChartData(dataSets: dataSets)
        data.setValueFont(.systemFont(ofSize: 7, weight: .light))
        chartView.data = data
    }
    
	/**
	Candlestick chart data setup
	*/
    func configureCandleStickChartData(for chartView: CandleStickChartView, quote: QuoteSymbol) {
        
        var dataEntries: [CandleChartDataEntry] = []
        
        for (index, _) in quote.timestamps.enumerated() {
            let highs = quote.highs[index]
            let lows = quote.lows[index]
            let opens = quote.opens[index]
            let closes = quote.closures[index]
            let chartDataEntry = CandleChartDataEntry(x: Double(index),
                                                      shadowH: highs,
                                                      shadowL: lows,
                                                      open: opens,
                                                      close: closes,
                                                      icon: nil)
            dataEntries.append(chartDataEntry)
        }
        
        let dataSet = CandleChartDataSet(entries: dataEntries, label: quote.symbol)
		dataSet.axisDependency = .left
		dataSet.setColor(UIColor(white: 80/255, alpha: 1))
		dataSet.drawIconsEnabled = false
		dataSet.shadowColor = .darkGray
		dataSet.shadowWidth = 0.7
		dataSet.decreasingColor = .red
		dataSet.decreasingFilled = true
		dataSet.increasingColor = UIColor(red: 122/255, green: 242/255, blue: 84/255, alpha: 1)
		dataSet.increasingFilled = false
		dataSet.neutralColor = .blue
        
        chartView.data = CandleChartData(dataSet: dataSet)
    }
}

