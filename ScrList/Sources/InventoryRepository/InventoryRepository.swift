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
    func fetch()
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
    
    private let inventoryListSubject = CurrentValuePublisher<[InventoryModel]>([])
    private let totalCountSubject = CurrentValuePublisher<Int>(0)
    
    public init(network: Network, baseURL: String, query: QueryItems, header: HTTPHeader) {
        self.netwrok = network
        self.baseURL = baseURL
        self.query = query
        self.header = header
        self.cancellables = .init()
    }
    
    public func fetch() {
        let request = InventoryRequest(baseURL: self.baseURL, query: query, header: header)
        netwrok.send(request).map(\.output)
            .sink(
                receiveCompletion: { _ in
                    print("CJHLOG: Finish~~~")
                },
                receiveValue: { [weak self] res in
                    self?.totalCountSubject.send(res.totalCount)
                    self?.inventoryListSubject.send(res.data)
                })
            .store(in: &cancellables)
    }
}
