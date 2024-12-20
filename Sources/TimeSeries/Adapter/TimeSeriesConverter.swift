//
//  TimeSeriesConverter.swift
//  Stocks
//
//  Created by Vitali Kurlovich on 20.12.24.
//

public protocol TimeSeriesConverter {
    associatedtype Input
    associatedtype Output

    func convert(date: FixedDate, input: Input) -> Output
}
