//
//  UInt40Tests.swift
//  Bluetooth
//
//  Created by Alsey Coleman Miller on 6/28/18.
//  Copyright © 2018 PureSwift. All rights reserved.
//

import XCTest
import Foundation
@testable import Bluetooth

final class UInt40Tests: XCTestCase {
    
    func testBitWidth() {
        
        XCTAssertEqual(UInt40.bitWidth, MemoryLayout<UInt40.ByteValue>.size * 8)
        XCTAssertEqual(UInt40.bitWidth, 40)
    }
    
    func testEquatable() {
        
        XCTAssertEqual(UInt40.zero, 0)
        XCTAssertEqual(UInt40.min, 0)
        XCTAssertEqual(UInt40.max, 1099511627775)
        XCTAssertEqual(UInt40.max, 0xFFFFFFFFFF)
    }

    func testHashable() {
        
        XCTAssertEqual(UInt40.zero.hashValue, UInt64(UInt40.zero).hashValue)
        XCTAssertEqual(UInt40.max.hashValue, UInt64(UInt40.max).hashValue)
        XCTAssertNotEqual(UInt40.max.hashValue, UInt64.max.hashValue)
    }
    
    func testExpressibleByIntegerLiteral() {
        
        let values: [(UInt40, String)] = [
            (UInt40.zero, "0000000000"),
            (0x0000000000, "0000000000"),
            (0x0000000001, "0000000001"),
            (0x0000000020, "0000000020"),
            (0xFFFE9ABCDE, "FFFE9ABCDE"),
            (1099511627775, "FFFFFFFFFF")
        ]
        
        values.forEach { XCTAssertEqual($0.description, $1) }
    }
}
