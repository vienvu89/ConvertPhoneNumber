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
        let stringClean = number.components(separatedBy: " ").joined()
        let replaceSmsStart = stringClean.replacingOccurrences(of: "+84", with: "0")
        if replaceSmsStart.count < 11  {
            return number
        }
        
        let first = replaceSmsStart.prefix(4)
        let last = replaceSmsStart.suffix(replaceSmsStart.count - 4)
        
        guard let firtConvert = dictChangeNumber[String(first)] else {
            return number
        }
        
        return firtConvert + last
    }
}
