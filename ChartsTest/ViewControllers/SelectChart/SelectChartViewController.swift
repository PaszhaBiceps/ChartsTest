//
//  SelectChartViewController.swift
//  ChartsTest
//
//  Created by Pavel Borisov on 12.10.2020.
//

import UIKit

class SelectChartViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets & Properties
    @IBOutlet private weak var tableView: UITableView!

	private let viewModel = SelectChartViewModel()
	private let cellName = "TableViewCell"
	private var items: [ChartType] = [] {
		didSet {
			tableView.reloadData()
		}
	}
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.title = viewModel.screenTitle
        setupTableView()
		items = viewModel.items
    }
    
    // MARK: - Setup UI
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
		tableView.separatorStyle = .singleLine
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:cellName)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewContoller: ChartViewController = ChartViewController.initWithNib()
        let chartDataType: ChartType
        
        switch items[indexPath.row] {
        case .monthly:
            chartDataType = .monthly
        case .weekly:
            chartDataType = .weekly
        }
        
        viewContoller.viewModel = ChartViewModel(screen: chartDataType)
        navigationController?.pushViewController(viewContoller, animated: true)
    }
}
