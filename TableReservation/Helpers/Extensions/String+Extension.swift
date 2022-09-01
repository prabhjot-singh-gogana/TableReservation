//
//  String+Extension.swift
//  TableReservation
//
//  Created by Prabhjot Singh Gogana on 31/8/2022.
//

import Foundation

extension String {
    func isEmptyOrWhitespace() -> Bool {
        if(self.isEmpty) {
            return true
        }
        return (self.trimmingCharacters(in: NSCharacterSet.whitespaces) == "")
    }
}
