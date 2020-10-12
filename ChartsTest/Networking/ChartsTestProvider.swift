//
//  ChartsTestProvider.swift
//  ChartsTest
//
//  Created by Pavel Borisov on 12.10.2020.
//

import Foundation
import Moya

final class ChartsTestProvider {
    
    // MARK: - Variables
    var provider: MoyaProvider<ChartsTestService>
    var localProvider: MoyaProvider<ChartsTestService>
    
    private var networkLoggerPlugin = NetworkLoggerPlugin(configuration: .init(formatter: .init(), output: { (target, array) in
        if let log = array.first {
            print(log)
        }
    }, logOptions: .formatRequestAscURL))

    
    // MARK: - Init
	init() {
		let plugins: [PluginType] = [networkLoggerPlugin]
		self.provider = MoyaProvider(plugins: plugins)
		self.localProvider = MoyaProvider(stubClosure: MoyaProvider<ChartsTestService>.immediatelyStub)
	}
}
