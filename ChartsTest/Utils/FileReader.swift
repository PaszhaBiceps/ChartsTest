//
//  FileReader.swift
//  ChartsTest
//
//  Created by Pavel Borisov on 12.10.2020.
//

import Foundation

protocol FileReader {
    func readFile(name: String, type: String) throws -> Data
}

enum ReadingError: Error {
	case fileNotFound(fileName: String)
	case errorReadingFile(fileName: String)
	
	var errorDescription: String {
		switch self {
		case .errorReadingFile(let fileName):
			return "Cannot read the file \(fileName)."
		case .fileNotFound(let fileName):
			return "File not found \(fileName)."
		}
	}
}

final class JsonFileReader: FileReader {
    func readFile(name: String, type: String) throws -> Data {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw ReadingError.fileNotFound(fileName: name)
        }
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            return jsonData
        } catch {
            throw ReadingError.errorReadingFile(fileName: name)
        }
    }
}

