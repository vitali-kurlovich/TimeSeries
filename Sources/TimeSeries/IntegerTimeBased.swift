//
//  IntegerTimeBased.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 10.12.24.
//

public protocol IntegerTimeBased {
    associatedtype IntegerTime: BinaryInteger
    var time: IntegerTime { get }

    func setTime(_ time: IntegerTime) -> Self
}
