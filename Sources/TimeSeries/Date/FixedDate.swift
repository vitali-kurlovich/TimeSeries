//
//  FixedDate.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 12.12.24.
//

import Foundation

public struct FixedDate: Hashable, Sendable {
    public let millisecondsFrom1970: Int

    public init(_ millisecondsFrom1970: Int) {
        self.millisecondsFrom1970 = millisecondsFrom1970
    }
}

public
extension FixedDate {
    static let zero = FixedDate(.zero)
}

extension FixedDate: Comparable {
    public static func < (lhs: FixedDate, rhs: FixedDate) -> Bool {
        lhs.millisecondsFrom1970 < rhs.millisecondsFrom1970
    }
}

public extension FixedDate {
    init(timeIntervalSince1970: TimeInterval) {
        let millisecondsFrom1970 = Int((timeIntervalSince1970 * 1000).rounded())
        self.init(millisecondsFrom1970)
    }

    init(_ date: Date) {
        self.init(timeIntervalSince1970: date.timeIntervalSince1970)
    }

    var timeIntervalSince1970: TimeInterval {
        TimeInterval(millisecondsFrom1970) / 1000
    }

    func adding<M: BinaryInteger>(milliseconds: M) -> Self {
        .init(millisecondsFrom1970 + Int(milliseconds))
    }

    internal func millisecondsSince(_ date: Self) -> Int {
        date.millisecondsFrom1970 - millisecondsFrom1970
    }
}

public extension Date {
    init(_ fixed: FixedDate) {
        self.init(timeIntervalSince1970: fixed.timeIntervalSince1970)
    }
}
