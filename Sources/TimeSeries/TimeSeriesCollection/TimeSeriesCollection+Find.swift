//
//  TimeSeriesCollection+Find.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 25.01.25.
//

public
extension TimeSeriesCollection {
    subscript(_ time: FixedDate) -> Element? {
        guard let index = index(with: time) else {
            return nil
        }
        return self[index]
    }
}

public
extension TimeSeriesElements {
    subscript(_ time: FixedDate) -> Element? {
        guard let index = collection.index(with: time) else {
            return nil
        }

        return collection.element(at: index)
    }
}
