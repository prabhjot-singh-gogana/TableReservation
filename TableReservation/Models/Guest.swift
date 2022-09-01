//
//  Guest.swift
//  TableReservation
//
//  Created by Prabhjot Singh Gogana on 31/8/2022.
//

import Foundation

struct Guest {
    var name, phoneNo: String?
    init(name:String, phoneNo: String) {
        self.name = name
        self.phoneNo = phoneNo
    }
}
