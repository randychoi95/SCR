//
//  File.swift
//  
//
//  Created by 최제환 on 2021/12/02.
//

import Foundation

public struct ScrModel: Codable {
    public let page: Int
    public let perPage: Int
    public let totalCount: Int
    public let currentCount: Int
    public let data: [OwnScrModel]
}

public struct OwnScrModel: Codable {
    public let 코드: String
    public let 명칭: String
    public let 주소: String
    public let 전화번호: String
    public let 영업시간: String
    public let 재고량: Int
    public let 가격: String
    public let 위도: String
    public let 경도: String
    public let 데이터기준일: String
}
