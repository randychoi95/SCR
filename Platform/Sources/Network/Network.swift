//
//  File.swift
//  
//
//  Created by 최제환 on 2021/12/02.
//

import Foundation
import Combine

public typealias QueryItems = [String: AnyHashable]
public typealias HTTPHeader = [String: String]

public protocol Request: Hashable {
    associatedtype Output: Codable
    
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var query: QueryItems { get }
    var header: HTTPHeader { get }
}

public protocol Network {
    func send<T: Request>(_ request: T) -> AnyPublisher<Response<T.Output>, Error>
}

public struct Response<T: Codable> {
    public let output: T
    public let statusCode: Int
    
    public init(output: T, statusCode: Int) {
        self.output = output
        self.statusCode = statusCode
    }
}
