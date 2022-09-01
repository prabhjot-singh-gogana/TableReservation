//
//  ReservationDetailsVC.swift
//  TableReservation
//
//  Created by Prabhjot Singh Gogana on 30/8/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ReservationDetailsVC: UIViewController {
    @IBOutlet weak var btnClose: UIBarButtonItem!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPartySize: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblNotes: UILabel!
    var viewModel = ReservationDetailsViewModel()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindingUI()
        // Do any additional setup after loading the view.
    }
    
    // method use to bind the UI elemtents
    func bindingUI() {
        self.btnClose.rx.tap.bind {
            self.dismiss(animated: true)
        }.disposed(by: self.bag)
        guard let reservation = self.viewModel.reservation else {return}
        self.lblName.text = reservation.guest?.name
        self.lblPartySize.text = "Party Size: \(reservation.table?.partySize ?? 0)"
        self.lblTime.text = "Time: \(reservation.table?.strStartTime ?? "")"
        self.lblPhone.text = reservation.guest?.phoneNo
        self.lblNotes.text = reservation.notes
    }

}
