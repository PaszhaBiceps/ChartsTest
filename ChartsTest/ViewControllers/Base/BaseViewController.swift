//
//  BaseViewController.swift
//  ChartsTest
//
//  Created by Pavel Borisov on 12.10.2020.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
	
	enum AlertType {
		case regular
		case error
	}
	
	func showOkAlert(of type: AlertType, with message: String) {
		let alert = UIAlertController(title: type == .error ? "Error" : nil,
									  message: message,
									  preferredStyle: .alert)
		alert.addAction(.init(title: "OK",
							  style: .default,
							  handler: nil))
		present(alert, animated: true)
	}
}
