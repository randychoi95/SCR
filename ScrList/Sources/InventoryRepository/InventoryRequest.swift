//
//  File.swift
//  
//
//  Created by 최제환 on 2021/12/13.
//

import Foundation
import Network
import InventoryEntity

struct InventoryRequest: Request {
    
    typealias Output = InventoryResponse
    
    var endpoint: String
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    init(baseURL: String, query: QueryItems, header: HTTPHeader) {
        self.endpoint = baseURL
        self.method = .get
        self.query = query
        self.header = header
    }
}

struct InventoryResponse: Codable {
    public let page: Int
    public let perPage: Int
    public let totalCount: Int
    public let currentCount: Int
    public let data: [InventoryModel]
}
