//
//  TableReservationTests.swift
//  TableReservationTests
//
//  Created by Prabhjot Singh Gogana on 30/8/2022.
//

import XCTest
@testable import TableReservation

class TableReservationTests: XCTestCase {
    var threePMDate: Date!
    var sixPMDate: Date!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
// 15 means 3 PM
        let threePMComp = DateComponents(hour: 15)
        threePMDate = Calendar.current.date(from: threePMComp)!
// 18 means 6 PM
        let sixPMComp = DateComponents(hour: 18)
        sixPMDate = Calendar.current.date(from: sixPMComp)!
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test15MinDateInterval() throws {
        let dates = Date.datesIn15minsInterval(startDate: threePMDate, endDate: sixPMDate)
        let times = dates.map({$0.localTime})
// expecting out ["3:00 PM", "3:15 PM", "3:30 PM", "3:45 PM", "4:00 PM", "4:15 PM", "4:30 PM", "4:45 PM", "5:00 PM", "5:15 PM", "5:30 PM", "5:45 PM", "6:00 PM"]
// TEST 4th index of times which should be 4:00 PM
        XCTAssert(times[4] == "4:00 PM")
// TEST last index of times which should be 6:00 PM
        XCTAssert(times.last == "6:00 PM")
// Test first index of dates should be equal to date with three PM
        XCTAssert(dates.first == threePMDate)
        
// TEST the datesIn15minsInterval with less than 15 minutes difference
// 3:10 PM Date
        let threeTenPMComp = DateComponents(hour: 15, minute: 10)
        guard let threeTenPMDate = Calendar.current.date(from: threeTenPMComp) else {fatalError()}
// 3:15 PM Date
        let threeFifteenPMComp = DateComponents(hour: 15, minute: 15)
        guard let threeFifteenPMDate = Calendar.current.date(from: threeFifteenPMComp) else {fatalError()}
        
        let dates1 = Date.datesIn15minsInterval(startDate: threeTenPMDate, endDate: threeFifteenPMDate)
        let times1 = dates1.map({$0.localTime})
// expecting out only one date which is 3:10 PM because as method says provides the dates in 15 mins interval which is not happening in this Test case
        XCTAssert(times1.last == "3:10 PM")
    }
    
//    In this test case available times and non available times. Also checks if single time is available or has available for an Hour at least or not available
    func testAvailabilities() {
        // all Times from 3 PM to 6 PM
        let allDates = Date.datesIn15minsInterval(startDate: threePMDate, endDate: sixPMDate)
        
// creating one reservation with 3 PM time
        let guest1 = Guest(name: "Pravi", phoneNo: "0458785456")
        let table1 = Table(startDate: threePMDate, size: 3)
        let tableReservation1 = Reservation(with: guest1, table: table1, notes: "Table must have a candle")
        
// creating second reservation with 5 PM time
        let fivePMComp = DateComponents(hour: 17)
        guard let fivePMDate = Calendar.current.date(from: fivePMComp) else {fatalError("Error")}
        let guest2 = Guest(name: "Navi", phoneNo: "0459845452")
        let table2 = Table(startDate: fivePMDate, size: 5)
        let tableReservation2 = Reservation(with: guest2, table: table2, notes: "Birthday Celeberation")
        
// array of reservations.
        let reservations = [tableReservation1, tableReservation2]
    
// adding two reservations array of date or time in to one array.
        let noAvailableTimes = reservations.reduce([Date]()) { partialResult, reservation -> [Date] in
            guard let table = reservation.table else {fatalError("Error")}
            let times = Date.datesIn15minsInterval(startDate: table.startTime, endDate: table.endTime)
            return (partialResult + times)
        }
// 1st test as one reservation consumes one hour or 60 minutes means 5 intervals for one reservation  3:00 PM, 3:15 PM, 3:30 PM, 3:45 PM, 4:00 PM. As we have two reservation so noAvailableTimes should have 10 elements. lets test that.
        XCTAssert(noAvailableTimes.count == 10)
// 2nd test to check first and last element
        XCTAssert(noAvailableTimes.first?.localTime == "3:00 PM")
        XCTAssert(noAvailableTimes.last?.localTime == "6:00 PM")
        
        let timesModels = allDates.map({ date -> TimeAvailability in
            var timeAvailability = TimeAvailability(time: date)
            timeAvailability.isAvailable = timeAvailability.isTimeAvailable(withNoAvailable: noAvailableTimes)
            return timeAvailability
        })
// 3rd test is to check if perticular time is available or not. As expecting 3:00 PM should not available.
        guard let time3 = timesModels.filter({$0.strTime == "3:00 PM"}).first else {fatalError("Error")}
        XCTAssert(time3.isAvailable == false)
// 4th test is to check if 4:15 is available or not. As expecting 4:15 PM should available.
        guard let time415 = timesModels.filter({$0.strTime == "4:15 PM"}).first else {fatalError("Error")}
        XCTAssert(time415.isAvailable == true)
        
// 5th test is to check if 4:15 is available for an Hour at least. expecting false
        XCTAssert(time415.hasAvailableForHourAtleast(noAvailableTime: noAvailableTimes) == false)
    }

    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
