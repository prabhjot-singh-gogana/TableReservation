//
//  RxExtension.swift
//  TableReservation
//
//  Created by Prabhjot Singh Gogana on 31/8/2022.
//

import Foundation
import RxSwift

public protocol OptionalType {
  associatedtype Wrapped
  var value: Wrapped? { get }
}

extension Optional: OptionalType {
  /// Cast `Optional<Wrapped>` to `Wrapped?`
  public var value: Wrapped? {
    return self
  }
}

public protocol Occupiable {
  var isEmpty: Bool { get }
  var isNotEmpty: Bool { get }
}

public extension Occupiable {
  var isNotEmpty: Bool {
    return !isEmpty
  }
}

extension String: Occupiable {}

public extension ObservableType where Element: OptionalType {
    func replaceNilWith(_ valueOnNil: Element.Wrapped) -> Observable<Element.Wrapped> {
      return map { element -> Element.Wrapped in
        guard let value = element.value else {
          return valueOnNil
        }
        return value
      }
    }
    
    func filterNil() -> Observable<Element.Wrapped> {
        return flatMap { element -> Observable<Element.Wrapped> in
          guard let value = element.value else {
            return Observable<Element.Wrapped>.empty()
          }
          return Observable<Element.Wrapped>.just(value)
        }
      }
}

public extension ObservableType where Element: Occupiable {
  func filterEmpty() -> Observable<Element> {
    return flatMap { element -> Observable<Element> in
      guard element.isNotEmpty else {
        return Observable<Element>.empty()
      }
      return Observable<Element>.just(element)
    }
  }
}

extension ObservableType where Element == String {


    func valueToMobileFormatted() -> Observable<Element> {
        return asObservable().flatMap { valueString -> Observable<Element> in
            let mobileStr = self.format(with: "(XX) XXXX XXXX", phone: valueString)
            return Observable.just(mobileStr)
      }
    }
    
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator
// iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])
                // move numbers iterator to the next index
                index = numbers.index(after: index)
            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
    
    
    
}
