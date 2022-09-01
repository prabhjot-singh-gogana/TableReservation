//
//  LocalStorage.swift
//  TableReservation
//
//  Created by Prabhjot Singh Gogana on 1/9/2022.
//

import Foundation
import RxRelay
import RxSwift
class LocalStorage {
    static let shared = LocalStorage()
    var reservations$ = BehaviorRelay<[Reservation]>.init(value: [])
    var noAvailableTimes = Date.datesOf15minsIntervalIn60Mins(startDate: Calendar.current.date(from: DateComponents(hour: 22, minute: 15))!)
    private let bag = DisposeBag()
    func initialiseNoAvailableTimes() {
        self.noAvailableTimes = reservations$.value.reduce(self.noAvailableTimes) { partialResult, reservation -> [Date] in
            guard let table = reservation.table else {return []}
            let times = Date.datesIn15minsInterval(startDate: table.startTime, endDate: table.endTime)
            return (partialResult + times)
        }
    }
}
