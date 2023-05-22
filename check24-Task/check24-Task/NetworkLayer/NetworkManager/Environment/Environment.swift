//
//  Environment.swift
//  check24-Task
//
//  Created by admin on 22/05/2023.
//

public enum Environment: String, CaseIterable {
    case development
    case staging
    case production
}

extension Environment {
    var serviceBaseUrl: String {
        switch self {
        case .development:
            return "http://app.check24.de/products-test.json"
        case .staging:
            return ""
        case .production:
            return ""
        }
    }
}
