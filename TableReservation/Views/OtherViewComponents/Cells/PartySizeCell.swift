//
//  PartySizeCell.swift
//  TableReservation
//
//  Created by Prabhjot Singh Gogana on 31/8/2022.
//

import UIKit

class PartySizeCell: UITableViewCell {
    @IBOutlet weak var lblPartySize: UILabel!
    
    func configure(size: Int) {
        self.lblPartySize.text = "\(size)"
    }

}
