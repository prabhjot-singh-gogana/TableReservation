//
//  TimeAvailability.swift
//  TableReservation
//
//  Created by Prabhjot Singh Gogana on 31/8/2022.
//

import Foundation

struct TimeAvailability {
    var time: Date
    var strTime: String {
        return time.localTime
    }
    var isAvailable: Bool = true
    
    init(time: Date) {
        self.time = time
    }
    
    func isTimeAvailable(withNoAvailable times: [Date]) -> Bool {
        return !times.contains(self.time)
    }
    func hasAvailableForHourAtleast(noAvailableTime:[Date] = LocalStorage.shared.noAvailableTimes) -> Bool {
        let times = Date.datesOf15minsIntervalIn60Mins(startDate: self.time)
        return !noAvailableTime.contains(times.last!)
    }
}
