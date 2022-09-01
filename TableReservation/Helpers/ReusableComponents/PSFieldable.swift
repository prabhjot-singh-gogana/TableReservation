//
//  PSFieldable.swift
//  TableReservation
//
//  Created by Prabhjot Singh Gogana on 31/8/2022.
//

import RxSwift
import RxCocoa
import Foundation

enum TypeField: Int {
    case textField
    case number
    case textView
    case stepper
    case datePicker
    case picker
    case link
}

//This protocols helps to tackle all the fields validations values, type, editing, errors in easy manner with observable.

protocol PSFieldable {
    var title: String { get}
    var errorMessage: String { get }
    var countRestric: Int {get}
    var type: TypeField {get set}
    var isEditable: Bool {get set}
    // Observables
    var value: BehaviorRelay<String> { get set }
    var errorValue: BehaviorRelay<String?> { get}
    
    // Validation
    func validate() -> Bool
}

extension PSFieldable {
    func validateSize(_ value: String, size: (min:Int, max:Int)) -> Bool {
        return (size.min...size.max).contains(value.count)
    }
    func validateString(_ value: String?, pattern: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", pattern)
        return test.evaluate(with: value)
    }
}


// --------  Data FieldViewModel : Password ---- -- -- -- - -//

struct PSPasswordable : PSFieldable {
    var isEditable = true
    
    var type: TypeField = .textField
    var countRestric = 25
    var value: BehaviorRelay<String> = BehaviorRelay(value: "")
    var errorValue: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    let title = "Password"
    let errorMessage = "Wrong password !"
    
    func validate() -> Bool {
        // between 8 and 25 caracters
        if !validateSize(value.value, size: (5,20)) || value.value.isEmptyOrWhitespace() {
            errorValue.accept(errorMessage)
            return false
        }
        errorValue.accept(nil)
        return true
    }
    
    func confirmPass(with pass: String) -> Bool {
        // between 8 and 25 caracters
        if value.value != pass || value.value.isEmptyOrWhitespace() {
            errorValue.accept("Password and Confirm Password are not same")
            return false
        }
        errorValue.accept(nil)
        return true
    }
}

// --------  Data FieldViewModel : GenericText ---- -- -- -- - -//

struct PSEmptyTypeFieldable: PSFieldable, Equatable {
    static func == (lhs: PSEmptyTypeFieldable, rhs: PSEmptyTypeFieldable) -> Bool {
        return (lhs.title == rhs.title)
    }
    
    var isEditable = true
    var value: BehaviorRelay<String> = BehaviorRelay(value: "")
    var errorValue: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    var type: TypeField = .textField
    var countRestric = 100
    var otherObject = BehaviorRelay<Any?>.init(value: nil)
    var isSpaceRequired = true
    var title = ""
    var errorMessage = "is Empty"
    
    init(_ title: String, withType: TypeField = TypeField.textField) {
        self.type = withType
        self.title = title
        self.errorMessage = "\(title) \(errorMessage)"
    }
    
    func validate() -> Bool {
        // between 8 and 25 caracters
        if value.value.isEmptyOrWhitespace()  {
            errorValue.accept(errorMessage)
            return false
        }
        errorValue.accept(nil)
        return true
    }
}


// --------   FieldViewModel : Email ---- -- -- -- - -//

struct PSEmailable : PSFieldable {
    
    var countRestric = 50
    var value: BehaviorRelay<String> = BehaviorRelay(value: "")
    var errorValue: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    var isEditable = true
    let title = "Email"
    let errorMessage = "Email is wrong"
    var type: TypeField = .textField
    
    func validate() -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@([A-Za-z0-9.-]{2,64})+\\.[A-Za-z]{2,64}"
        guard validateString(value.value, pattern:emailPattern) else {
            errorValue.accept(errorMessage)
            return false
        }
        errorValue.accept(nil)
        return true
    }
}

