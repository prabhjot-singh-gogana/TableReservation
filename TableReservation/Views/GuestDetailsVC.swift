//
//  GuestDetailsVC.swift
//  TableReservation
//
//  Created by Prabhjot Singh Gogana on 30/8/2022.
//

import UIKit
import RxSwift
import RxCocoa

class GuestDetailsVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtNotes: UITextField!
    @IBOutlet weak var btnSave: UIBarButtonItem!
    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    var viewModel = GuestDetailViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindingUI()
        // Do any additional setup after loading the view.
    }
    
// method use to bind the UI elemtents
    func bindingUI() {
// textName is binding with self.viewModel.name$ after filteration
        self.txtName.rx
            .text
            .orEmpty
            .changed
            .filter({ value in
                if (value.count <= self.viewModel.name$.countRestric) { return true }
                self.txtName.text = self.viewModel.name$.value.value
                return false
            })
            .bind { value in
                self.txtName.text = value
                self.viewModel.name$.value.accept(value)
            }.disposed(by: self.disposeBag)
        
// txtPhone is binding with self.viewModel.phoneNo$ after filteration
        self.txtPhone.keyboardType = .numberPad
        self.txtPhone.rx
            .text
            .orEmpty
            .changed
            .filter({ value in
                if (value.count <= self.viewModel.phoneNo$.countRestric) { return true }
                self.txtPhone.text = self.viewModel.phoneNo$.value.value
                return false
            })
            .valueToMobileFormatted() // foramting the phone number
            .bind { value in
                self.txtPhone.text = value
                self.viewModel.phoneNo$.value.accept(value)
            }.disposed(by: self.disposeBag)

// txtNotes is binding with self.viewModel.notes$$ after filteration
        self.txtNotes.rx
            .text
            .orEmpty
            .changed
            .bind(to: self.viewModel.notes$.value)
            .disposed(by: self.disposeBag)
        
// click button to save
        self.btnSave.rx.tap
            .filter{self.viewModel.validForm()}
            .bind { self.viewModel.toSave()}
            .disposed(by: self.disposeBag)
        
// message alert if validation fails
        self.viewModel.message
            .filterNil()
            .bind { errorMessage in
                self.present(UIAlertController.alert(message: errorMessage), animated: true)
            }.disposed(by: disposeBag)
        
        
// if Successfully created the Reservation object in LocalStorage function will initialise the "no available" times object and then pop to first screen
        self.viewModel.isSuccess$.subscribe(on: MainScheduler.instance)
            .filter { $0 }
            .subscribe(onNext: { _ in
                LocalStorage.shared.initialiseNoAvailableTimes()
                self.navigationController?.popToRoot()
             }).disposed(by: self.disposeBag)
        
// pop the screen after clicking on back button
        self.btnBack.rx.tap.bind {
            self.navigationController?.pop()
        }.disposed(by: self.disposeBag)
        
// pop to root the screen after clicking on back button
        self.btnCancel.rx.tap.bind {
            self.navigationController?.popToRoot()
        }.disposed(by: self.disposeBag)
    }
}
