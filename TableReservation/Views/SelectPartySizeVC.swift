//
//  SelectPartySizeVC.swift
//  TableReservation
//
//  Created by Prabhjot Singh Gogana on 30/8/2022.
//

import UIKit
import RxCocoa
import RxSwift

class SelectPartySizeVC: UITableViewController {
    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    var viewModel = SelectPartySizeViewModel()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.bindingUI()
        self.viewModel.initalisePatySizes()
    }
    
// method use to bind the UI elemtents
    func bindingUI() {
//nil the tableview delegates so that RxCocoa can use their delegates
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
//bind model with table view.
        self.viewModel.partySizes$.bind(to: self.tableView.rx.items(cellIdentifier: String(describing: PartySizeCell.self), cellType: PartySizeCell.self)) { _, element, cell in
            cell.configure(size: element)
        }.disposed(by: self.bag)

// did Select the table view with party size no
        self.tableView.rx
            .modelSelected(Int.self)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { element in
                self.performSegue(withIdentifier: "toGuestDetailSeagueIdentifier", sender: element)
            }).disposed(by: self.bag)
        
// pop the screen after clicking on back button
        self.btnBack.rx.tap.bind {
            self.navigationController?.pop()
        }.disposed(by: self.bag)
        
// pop to root the screen after clicking on back button
        self.btnCancel.rx.tap.bind {
            self.navigationController?.popToRoot()
        }.disposed(by: self.bag)
        
    }
// get call when segue performs
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGuestDetailSeagueIdentifier" {
            guard let guestDetail = segue.destination as? GuestDetailsVC else {return}
            guard let size = sender as? Int else {return}
            guard let timeAvl = self.viewModel.time else {return}
            guestDetail.viewModel.timeAvl = timeAvl
            guestDetail.viewModel.partySizeNo = size
        }
    }
}
