//
//  File.swift
//  
//
//  Created by 최제환 on 2021/12/03.
//

import Foundation
import Network
import Combine
import CombineUtil
import ScrEntity

public protocol ScrRepository {
    var scrList: ReadOnlyCurrentValuePublisher<[OwnScrModel]> { get }
    func fetch()
}

public final class ScrRepositoryImp: ScrRepository {
    private let netwrok: Network
    private let baseURL: String
    private let query: QueryItems
    private var cancellables: Set<AnyCancellable>

    public var scrList: ReadOnlyCurrentValuePublisher<[OwnScrModel]> {
        scrListSubject
    }
    
    private let scrListSubject = CurrentValuePublisher<[OwnScrModel]>([])
    
    public init(network: Network, baseURL: String, query: QueryItems) {
        self.netwrok = network
        self.baseURL = baseURL
        self.query = query
        self.cancellables = .init()
    }
    
    public func fetch() {
        print("running")
        let request = ScrRequest(baseURL: self.baseURL, query: query)
        netwrok.send(request).map(\.output.data)
            .sink(
                receiveCompletion: { _ in
                    print("finish~!!")
                },
                receiveValue: { [weak self] data in
                    self?.scrListSubject.send(data)
                })
            .store(in: &cancellables)
    }
}
