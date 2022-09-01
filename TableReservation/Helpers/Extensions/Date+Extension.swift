//
//  Date+Extension.swift
//  TableReservation
//
//  Created by Prabhjot Singh Gogana on 31/8/2022.
//

import Foundation
extension Date {
    static func datesIn15minsInterval(startDate: Date, endDate: Date) -> [Date] {
        var dates = [Date]()
        var startDateTemp = startDate
        repeat {
            dates.append(startDateTemp)
            guard let newDate = Calendar.current.date(byAdding: .minute, value: 15, to: startDateTemp) else { return dates }
            startDateTemp = newDate
        } while startDateTemp <= endDate
        return dates
    }
    
    static func datesOf15minsIntervalIn60Mins(startDate: Date) -> [Date] {
        let endDate = Calendar.current.date(byAdding: .minute, value: 60, to: startDate)!
        var dates = [Date]()
        var startDateTemp = startDate
        repeat {
            dates.append(startDateTemp)
            guard let newDate = Calendar.current.date(byAdding: .minute, value: 15, to: startDateTemp) else { return dates }
            startDateTemp = newDate
        } while startDateTemp <= endDate
        return dates
    }
    
    var localTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        return formatter.string(from: self)
    }
}
