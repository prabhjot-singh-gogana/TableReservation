//
//  ReservationListVC.swift
//  TableReservation
//
//  Created by Prabhjot Singh Gogana on 30/8/2022.
//

import UIKit
import RxSwift
import RxCocoa

final class ReservationListVC: UITableViewController {

    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindingUI()
    }
    
// method use to bind the UI elemtents
    func bindingUI() {
//nil the tableview delegates so that RxCocoa can use their delegates
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        
//storing the reservation in shared object and bind it with table view.
        LocalStorage.shared.reservations$.bind(to: self.tableView.rx.items(cellIdentifier: String(describing: ReservationListCell.self), cellType: ReservationListCell.self)) { row, element, cell in
            cell.configure(with: element,serialNo: row + 1)
        }.disposed(by: self.bag)
        
// did slect row with nodel reservation.
        self.tableView.rx
            .modelSelected(Reservation.self)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { element in
                self.performSegue(withIdentifier: "toReservayiontlSeagueIdentifier", sender: element)
            }).disposed(by: self.bag)
    }
    
// get call when segue performs
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toReservayiontlSeagueIdentifier" {
            guard let resDetails = segue.destination as? ReservationDetailsVC else {return}
            guard let reservation = sender as? Reservation else {return}
            resDetails.viewModel.reservation = reservation
        }
    }
}

