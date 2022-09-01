//
//  SelectTimeVC.swift
//  TableReservation
//
//  Created by Prabhjot Singh Gogana on 30/8/2022.
//

import UIKit
import RxSwift

class SelectTimeVC: UITableViewController {

    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    let viewModel = SelectTimeViewModel()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindingUI()
        self.viewModel.initaliseTimeAvailabilities()
    }
    
// method use to bind the UI elemtents
    func bindingUI() {
//nil the tableview delegates so that RxCocoa can use their delegates
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
//bind model with table view.
        self.viewModel.timesAvailabilites$.bind(to: self.tableView.rx.items(cellIdentifier: String(describing: TimeCell.self), cellType: TimeCell.self)) { row, element, cell in
            cell.configure(with: element)
        }.disposed(by: self.bag)

// did Select the table view with TimeAvailability Model
        self.tableView.rx
            .modelSelected(TimeAvailability.self)
            .filter({self.viewModel.isValidate(element: $0)}) // validate the object and its dates
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { element in
                self.toPartySizeScreen(element: element)
            }).disposed(by: self.bag)

// message alert if validation fails
        self.viewModel.message
            .filterNil()
            .bind { errorMessage in
                self.present(UIAlertController.alert(message: errorMessage), animated: true)
            }.disposed(by: self.bag)
        
// pop the screen after clicking on back button
        self.btnBack.rx.tap.bind {
            self.navigationController?.pop()
        }.disposed(by: self.bag)
        
// pop to root the screen after clicking on back button
        self.btnCancel.rx.tap.bind {
            self.navigationController?.popToRoot()
        }.disposed(by: self.bag)
    }

    func toPartySizeScreen(element: TimeAvailability) {
        self.performSegue(withIdentifier: "toPartySizeSeagueIdentifier", sender: element)
    }

// get call when segue performs
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPartySizeSeagueIdentifier" {
            guard let partySizeVC = segue.destination as? SelectPartySizeVC else {return}
            guard let timeAvl = sender as? TimeAvailability else {return}
            partySizeVC.viewModel.time = timeAvl
        }
    }

}
