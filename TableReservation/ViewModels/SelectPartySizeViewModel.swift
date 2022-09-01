//
//  SelectPartySizeViewModel.swift
//  TableReservation
//
//  Created by Prabhjot Singh Gogana on 31/8/2022.
//

import Foundation
import RxSwift
import RxRelay

struct SelectPartySizeViewModel {
    var partySizes$ = BehaviorRelay<[Int]>.init(value: [])
    var time: TimeAvailability?
    
    func initalisePatySizes() {
        self.partySizes$.accept([1,2,3,4,5])
    }
    
}
