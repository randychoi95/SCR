//
//  File.swift
//  
//
//  Created by 최제환 on 2021/12/13.
//

import Foundation

public struct Inventory: Codable {
    public let page: Int
    public let perPage: Int
    public let totalCount: Int
    public let currentCount: Int
    public let data: [InventoryModel]
}

public struct InventoryModel: Codable {
    public let addr: String
    // 주유소 주소

    public let code: String
    // 주유소 코드

    public let inventory: String
    // 재고량

    public let lat: String
    // 주유소 위도

    public let lng: String
    // 주유소 경도

    public let name: String
    // 주유소 이름

    public let openTime: String?
    // 영업시간

    public let price: String
    // 요소수 가격

    public let regDt: String
    // 업데이트 일시

    public let tel: String
    // 주유소 전화번호

    public let color: String
    // 잔량 수량 구간
}
