//
//  UIViewController+Extension.swift
//  ChartsTest
//
//  Created by Pavel Borisov on 12.10.2020.
//

import Foundation
import UIKit

extension UIViewController {
	/**
	Inits view controller fron UINib.
	*/
	class func initWithNib<T : UIViewController>() -> T {
		return self.init(nibName: String(describing: self.classForCoder()), bundle: nil) as! T
	}
}
