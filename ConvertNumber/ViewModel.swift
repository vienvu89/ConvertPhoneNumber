//
//  ViewModel.swift
//  ConvertNumber
//
//  Created by Vien Vu on 9/28/18.
//  Copyright © 2018 Vien Vu. All rights reserved.
//

import UIKit

class ViewModel: NSObject {
    
    var dictChangeNumber = [
        "0120" : "070",
        "0121" : "079",
        "0122" : "077",
        "0126" : "076",
        "0128" : "078",
        "0123" : "083",
        "0124" : "084",
        "0125" : "085",
        "0127" : "081",
        "0129" : "082",
        "0162" : "032",
        "0163" : "033",
        "0165" : "035",
        "0166" : "036",
        "0167" : "037",
        "0168" : "038",
        "0169" : "039",
        "0186" : "056",
        "0188" : "058",
        "0199" : "059"
    ]
    
    func converNumber(number: String) -> String {
        let last = String(number.suffix(7))
        let first = number.replacingOccurrences(of: last, with: "")
        let firstChanged = exchangeOldToNew(string: first)
        
        return firstChanged + last
    }

    func exchangeOldToNew(string : String) -> String {
        let firstConvert = convertToZeroStart(string: string)
        
        return dictChangeNumber[firstConvert] ?? ""
    }
    
    func convertToZeroStart(string: String) -> String {
        return string.replacingOccurrences(of: "+84", with: "0")
    }
}
