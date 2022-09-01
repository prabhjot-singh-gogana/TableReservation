//
//  GuestDetailViewModel.swift
//  TableReservation
//
//  Created by Prabhjot Singh Gogana on 31/8/2022.
//

import Foundation
import RxSwift
import RxRelay

struct GuestDetailViewModel {
    var name$ = PSEmptyTypeFieldable("Guest Name")
    var phoneNo$ = PSEmptyTypeFieldable("Guest Phone No")
    var notes$ = PSEmptyTypeFieldable("Notes")
    var message = BehaviorRelay<String?>(value: nil)
    var isSuccess$ = BehaviorRelay<Bool>(value: false)
    var timeAvl: TimeAvailability?
    var partySizeNo: Int?
    let disposeBag = DisposeBag()
    
    init() {
        phoneNo$.countRestric = 14
        self.messageBindingForValidation()
    }
    
    // combining the error messages and bind with message.
    func messageBindingForValidation() {
        let m1 = name$.errorValue.replaceNilWith("")
        let m2 = phoneNo$.errorValue.replaceNilWith("")

        Observable.combineLatest(m1, m2, resultSelector: {f1,f2 in
            return  f1 + f2
        }).filterEmpty().bind(to: self.message).disposed(by: self.disposeBag)
    }
    
    
// checks the validation before sending the data to next screen.
    func validForm() -> Bool {
        return name$.validate() && phoneNo$.validate()
    }
    
// after click on Save button this method will invokes which binds with isSuccess relay.
    func toSave() {
        guard let timeAvl = timeAvl else {
            return
        }
        guard let partySizeNo = partySizeNo else {
            return
        }
// creating reservation object and save it localstorage
        var allReservations = LocalStorage.shared.reservations$.value
        let reservation = Reservation(with: Guest(name: self.name$.value.value, phoneNo: self.phoneNo$
            .value.value), table: Table(startDate: timeAvl.time, size: partySizeNo), notes: self.notes$.value.value)
        allReservations.append(reservation)
        LocalStorage.shared.reservations$.accept(allReservations)
        isSuccess$.accept(true)
    }
    
}
