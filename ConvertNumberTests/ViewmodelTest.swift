//
//  ViewmodelTest.swift
//  ConvertNumberTests
//
//  Created by Vien Vu on 9/28/18.
//  Copyright © 2018 Vien Vu. All rights reserved.
//

import Nimble
import Quick

class ViewmodelTest: QuickSpec {
    override func spec() {
        super.spec()
        
        let viewModel = ViewModel()
        describe("Test exchane Old To nex") {
            it("should pass") {
                expect(viewModel.exchangeOldToNew(string: "0120")).to(equal("070"))
            }
        }
        describe("Test convert to zero start") {
            it("should fail") {
                expect(viewModel.convertToZeroStart(string: "+84123")).to(equal("0123"))
            }
        }

        describe("Test convert number") {
            it("should convert to new number") {
                expect(viewModel.converNumber(number: "01652679159")).to(equal("0352679159"))
            }
        }
    }
}
