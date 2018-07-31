//
//  HCIInquiryResult.swift
//  Bluetooth
//
//  Created by Carlos Duclos on 7/30/18.
//  Copyright © 2018 PureSwift. All rights reserved.
//

import Foundation

public struct HCIInquiryResult: HCIEventParameter {
    
    public static let event = HCIGeneralEvent.inquiryResult
    
    public static let length = 2 + 1 + Report.length
    
    public var reports: [Report]
    
    public init?(data: Data) {
        
        guard data.count >= type(of: self).length
            else { return nil }
        
        let reportCount = Int(data[2])
        
        guard (data.count - 2) / Report.length >= reportCount
            else { return nil }
        
        var reports = [Report]()
        reports.reserveCapacity(reportCount)
        
        var offset = 3
        for _ in 0 ..< reportCount {
            
            let reportBytes = Data(data.suffix(from: offset))
            
            guard let report = Report(data: reportBytes)
                else { return nil }
            
            offset += Report.length
            reports.append(report)
        }
        
        self.reports = reports
    }
}

extension HCIInquiryResult {
    
    public struct Report {
        
        public static let length = 6 + 1 + 1 + 1 + 3 + 2
        
        public var address: Address
        
        public var pageScanRepetitionMode: PageScanRepetitionMode
        
        public var clockOffset: ClockOffset
        
        public init?(data: Data) {
            
            let address = Address(littleEndian: Address(bytes: (data[0], data[1], data[2], data[3], data[4], data[5])))
            
            guard let pageScanRepetitionMode = PageScanRepetitionMode(rawValue: data[6])
                else { return nil }
            
            let clockOffset = ClockOffset(rawValue: UInt16(littleEndian: UInt16(bytes: (data[12], data[13]))))
            
            self.address = address
            self.pageScanRepetitionMode = pageScanRepetitionMode
            self.clockOffset = clockOffset
        }
        
    }
}

extension HCIInquiryResult {
    
    public struct ClockOffset: RawRepresentable {
        
        public static let length = MemoryLayout<UInt16>.size
        
        public var rawValue: UInt16
        
        public init(rawValue: UInt16) {
            
            self.rawValue = rawValue
        }
    }
}
