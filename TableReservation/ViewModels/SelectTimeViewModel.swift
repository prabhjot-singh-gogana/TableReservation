//
//  SelectTimeViewModel.swift
//  TableReservation
//
//  Created by Prabhjot Singh Gogana on 31/8/2022.
//

import Foundation
import RxSwift
import RxRelay

struct SelectTimeViewModel {
    var timesAvailabilites$ = BehaviorRelay<[TimeAvailability]>.init(value: [])
    var message = BehaviorRelay<String?>(value: nil)
    var isSuccessWithElement$ = BehaviorRelay<TimeAvailability?>(value: nil)
    
// creating times 15 minuts interval from 3 til 10 o clock then create a model with its availability
    func initaliseTimeAvailabilities() {
        let threePMComp = DateComponents(hour: 15) // 3:00 PM
        guard let threePMDate = Calendar.current.date(from: threePMComp) else {return}
        let tenPMComp = DateComponents(hour: 22)// 10:00 PM
        guard let tenPMDate = Calendar.current.date(from: tenPMComp) else {return}
        
        self.timesAvailabilites$.accept(Date.datesIn15minsInterval(startDate: threePMDate, endDate: tenPMDate).map { time -> TimeAvailability in
            var timeAvailability = TimeAvailability(time: time)
            timeAvailability.isAvailable = timeAvailability.isTimeAvailable(withNoAvailable: LocalStorage.shared.noAvailableTimes.map({$0}))
            return timeAvailability
        })
    }
    
// checks the validation before sending the data to next screen.
    func isValidate(element: TimeAvailability) -> Bool {
        if element.isAvailable == true {
            if element.hasAvailableForHourAtleast() == true {
                return true
            } else {
                self.message.accept("Need atleast 60 minutes gap for table booking")
            }
        } else {
            self.message.accept("This time is not available. Please choose available times.")
        }
        return false
    }
}
