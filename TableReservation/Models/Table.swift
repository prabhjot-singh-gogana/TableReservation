//
//  Table.swift
//  TableReservation
//
//  Created by Prabhjot Singh Gogana on 31/8/2022.
//

import Foundation

struct Table {
    var startTime: Date
    var partySize: Int
    var endTime: Date {
        return Calendar.current.date(byAdding: .minute, value: 60, to: startTime) ?? startTime
    }
    var strStartTime: String {
        return startTime.localTime
    }
    var strEndTime: String {
        return endTime.localTime
    }

    init(startDate: Date, size: Int) {
        self.startTime = startDate
        self.partySize = size
    }
}
