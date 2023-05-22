//
//  RequestableProtocol.swift
//  check24-Task
//
//  Created by admin on 22/05/2023.
//

import Combine
import Foundation

public protocol Requestable {
    var requestTimeOut: Float { get }
    func request<T: Codable>(_ req: NetworkRequest) -> AnyPublisher<T, NetworkError>
}
