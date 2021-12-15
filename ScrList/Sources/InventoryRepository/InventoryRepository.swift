//
//  File.swift
//  
//
//  Created by 최제환 on 2021/12/13.
//

import Foundation
import Network
import Combine
import CombineUtil
import ScrUI
import InventoryEntity

public protocol InventoryRepository {
    var inventoryList: ReadOnlyCurrentValuePublisher<[InventoryModel]> { get }
    var totalCount: ReadOnlyCurrentValuePublisher<Int> { get }
    var page: ReadOnlyCurrentValuePublisher<Int> { get }
    func fetchScrList()
}

public final class InventoryRepositoryImp: InventoryRepository {
    private let netwrok: Network
    private let baseURL: String
    private var query: QueryItems
    private var header: HTTPHeader
    private var cancellables: Set<AnyCancellable>
    
    public var inventoryList: ReadOnlyCurrentValuePublisher<[InventoryModel]> {
        inventoryListSubject
    }
    
    public var totalCount: ReadOnlyCurrentValuePublisher<Int> {
        return totalCountSubject
    }
    
    public var page: ReadOnlyCurrentValuePublisher<Int> {
        return pageSubject
    }
    
    private let inventoryListSubject = CurrentValuePublisher<[InventoryModel]>([])
    private let totalCountSubject = CurrentValuePublisher<Int>(0)
    private let pageSubject = CurrentValuePublisher<Int>(0)
    
    public init(network: Network, baseURL: String, query: QueryItems, header: HTTPHeader) {
        self.netwrok = network
        self.baseURL = baseURL
        self.query = query
        self.header = header
        self.cancellables = .init()
    }
    
    public func fetchScrList()  {
        let request = InventoryRequest(baseURL: self.baseURL, query: query, header: header)
        netwrok.send(request).map(\.output)
            .sink(receiveCompletion: { _ in }) { res in
                self.inventoryListSubject.send(self.inventoryListSubject.value + res.data)
                self.totalCountSubject.send(res.totalCount)
                self.pageSubject.send(res.page)
            }.store(in: &cancellables)
    }
    
    
}
