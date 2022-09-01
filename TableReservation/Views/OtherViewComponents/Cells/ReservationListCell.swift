//
//  ReservationListCell.swift
//  TableReservation
//
//  Created by Prabhjot Singh Gogana on 31/8/2022.
//

import UIKit

class ReservationListCell: UITableViewCell {
    @IBOutlet weak var lblSerialNo: UILabel!
    @IBOutlet weak var lblGuestName: UILabel!
    @IBOutlet weak var lblStartTIme: UILabel!
    func configure(with reservation: Reservation, serialNo: Int = 0) {
        self.lblSerialNo.text = "\(serialNo)"
        if let guest = reservation.guest {
            self.lblGuestName.text = guest.name ?? ""
        }
        if let table = reservation.table {
            self.lblStartTIme.text = table.strStartTime
        }
    }
}
