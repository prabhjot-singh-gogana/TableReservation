//
//  TimeCell.swift
//  TableReservation
//
//  Created by Prabhjot Singh Gogana on 31/8/2022.
//

import UIKit

class TimeCell: UITableViewCell {
    @IBOutlet weak var lblTIme: UILabel!
    @IBOutlet weak var lblAvailable: UILabel!
    func configure(with timeAvailability: TimeAvailability) {
        self.lblTIme.text = timeAvailability.strTime
        self.lblAvailable.text = timeAvailability.isAvailable ? "Available": "Not Available"
    }

}
