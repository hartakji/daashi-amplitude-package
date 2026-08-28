//
//  MonthlyActiveUsersStoreProtocol.swift
//  AmplitudeWidget
//
//  Created by Jean DAHER on 28/08/2026.
//

import Foundation

struct MonthlyActiveUsersStore {
    
    public enum Error: Swift.Error {
        case invalidUrl
        case invalidData
    }
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter
    }()
    
    var authorization: String
    
    public init(apiKey: String, secretKey: String) {
        authorization = "\(apiKey):\(secretKey)".toBase64()
    }
}

extension MonthlyActiveUsersStore: MonthlyActiveUsersStoreProtocol {
    
    func getCurrentMonthsActiveUsers(
        startDate: Date,
        endDate: Date
    ) async throws -> ActiveUsers {
        
        let startDateString = dateFormatter.string(from: startDate)
        let endDateString = dateFormatter.string(from: endDate)
        let urlString = "https://amplitude.com/api/2/users?start=\(startDateString)&end=\(endDateString)&m=active&i=30"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let urlString, let url = URL(string: urlString) else {
            throw Error.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(authorization)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        let activeUsersDTO = try decoder.decode(MonthlyActiveUsersDTO.self, from: data)
        
        let seriesDateFormatter = DateFormatter()
        seriesDateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard activeUsersDTO.data.series.count == 1,
              activeUsersDTO.data.series[0].count == 2,
              activeUsersDTO.data.xValues.count == 2,
              let currentMonthStartDate = seriesDateFormatter.date(from: activeUsersDTO.data.xValues[1])
        else { throw Error.invalidData }
        
        return ActiveUsers(currentMonth: activeUsersDTO.data.series[0][1],
                           currentMonthStartDate: currentMonthStartDate,
                           lastMonth: activeUsersDTO.data.series[0][0])
    }
}

extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        Data(self.utf8).base64EncodedString()
    }
    
}
