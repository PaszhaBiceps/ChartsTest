//
//  ChartsTestService.swift
//  ChartsTest
//
//  Created by Pavel Borisov on 12.10.2020.
//

import Foundation
import Moya

enum ChartsTestService {
    case quotesWeek
    case quotesMonth
}

extension ChartsTestService: TargetType {
    
    var baseURL: URL {
        return Constants.baseURL
    }
    
    var path: String {
        switch self {
        case .quotesWeek:
            return "quotesWeek"
        case .quotesMonth:
            return "quotesMonth"
        }
    }
    
    var method: Moya.Method {
        switch self {
		default:
			return .get
        }
    }
    
    var headers: [String : String]? {
		switch self {
		default:
			return nil
		}
    }
    
    var sampleData: Data {
        switch self {
        case .quotesWeek:
            do {
				let responseQuotesWeekData = try JsonFileReader().readFile(name: Constants.Strings.FileNames.weeklyQuotes,
																		   type: Constants.Strings.FileTypes.json)
                return responseQuotesWeekData
            } catch let readingError as ReadingError {
                print(readingError.errorDescription)
            } catch {
                print(error.localizedDescription)
            }
            return Data()
        case .quotesMonth:
            do {
                let responseQuotesWeekData = try JsonFileReader().readFile(name: Constants.Strings.FileNames.monthlyQuotes,
																		   type: Constants.Strings.FileTypes.json)
                return responseQuotesWeekData
            } catch let readingError as ReadingError {
                print(readingError.errorDescription)
            } catch {
                print(error.localizedDescription)
            }
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }
}
