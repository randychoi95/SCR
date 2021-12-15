//
//  File.swift
//  
//
//  Created by 최제환 on 2021/12/15.
//

import Foundation

struct Formatter {
    static let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}
