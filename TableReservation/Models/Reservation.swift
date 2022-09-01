//
//  Reservation.swift
//  TableReservation
//
//  Created by Prabhjot Singh Gogana on 30/8/2022.
//

import Foundation

struct Reservation {
    var guest: Guest?
    var table: Table?
    var notes: String = ""
    init(with guest: Guest, table: Table, notes: String = "") {
        self.guest = guest
        self.table = table
        self.notes = notes
    }
}

