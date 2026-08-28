//
//  MonthlyActiveUsersDataDTO.swift
//  
//
//  Created by Jean DAHER on 24/08/2024.
//

import Foundation

struct MonthlyActiveUsersDataDTO: Decodable {
    var xValues: [String]
    var series: [[Int]]
}
