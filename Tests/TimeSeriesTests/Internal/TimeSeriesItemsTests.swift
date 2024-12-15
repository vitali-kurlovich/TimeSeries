//
//  TimeSeriesItemsTests.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 12.12.24.
//

import Testing
@testable import TimeSeries

struct TimeSeriesItemsTests {
    @Test("Merge the same TimeSeriesItems")
    func mergeSame() throws {
        let leftItems: [MocItem] = [
            MocItem(time: 0, index: 1),
            MocItem(time: 10, index: 2),
        ]

        let rightItems: [MocItem] = [
            MocItem(time: 0, index: 1),
            MocItem(time: 10, index: 2),
        ]

        let expected: [MocItem] = [
            MocItem(time: 0, index: 1),
            MocItem(time: 0, index: 1),
            MocItem(time: 10, index: 2),
            MocItem(time: 10, index: 2),
        ]

        #expect(expected == Array(leftItems.merge(rightItems)))
    }

    @Test("Merge TimeSeriesItem")
    func merge() throws {
        let leftItems: [MocItem] = [
            MocItem(time: 0, index: 0),
            MocItem(time: 10, index: 1),
            MocItem(time: 30, index: 3),
            MocItem(time: 50, index: 5),
            MocItem(time: 60, index: 6),
            MocItem(time: 70, index: 7),
            MocItem(time: 80, index: 8),
        ]

        let rightItems: [MocItem] = [
            MocItem(time: 20, index: 2),
            MocItem(time: 30, index: 3),
            MocItem(time: 40, index: 4),
            MocItem(time: 60, index: 6),
        ]

        let expected: [MocItem] = [
            MocItem(time: 0, index: 0),
            MocItem(time: 10, index: 1),
            MocItem(time: 20, index: 2),
            MocItem(time: 30, index: 3),
            MocItem(time: 30, index: 3),
            MocItem(time: 40, index: 4),
            MocItem(time: 50, index: 5),
            MocItem(time: 60, index: 6),
            MocItem(time: 60, index: 6),
            MocItem(time: 70, index: 7),
            MocItem(time: 80, index: 8),
        ]

        #expect(expected == Array(leftItems.merge(rightItems)))
        #expect(expected == Array(rightItems.merge(leftItems)))
    }

    @Test("Remove duplicates from TimeSeriesItems")
    func removeDuplicates() throws {
        let sequence: [MocItem] = [
            MocItem(time: 0, index: 0),
            MocItem(time: 0, index: 0),
            MocItem(time: 10, index: 1),
            MocItem(time: 20, index: 2),
            MocItem(time: 30, index: 3),
            MocItem(time: 30, index: 3),
            MocItem(time: 40, index: 4),
            MocItem(time: 50, index: 5),
            MocItem(time: 60, index: 6),
            MocItem(time: 60, index: 6),
            MocItem(time: 70, index: 7),
            MocItem(time: 80, index: 8),
            MocItem(time: 80, index: 8),
            MocItem(time: 80, index: 8),
            MocItem(time: 80, index: 8),
            MocItem(time: 80, index: 8),
        ]

        let expected: [MocItem] = [
            MocItem(time: 0, index: 0),
            MocItem(time: 10, index: 1),
            MocItem(time: 20, index: 2),
            MocItem(time: 30, index: 3),
            MocItem(time: 40, index: 4),
            MocItem(time: 50, index: 5),
            MocItem(time: 60, index: 6),
            MocItem(time: 70, index: 7),
            MocItem(time: 80, index: 8),
        ]

        #expect(expected == Array(sequence.removeDuplicates()))
    }

    @Test("Remove duplicates from TimeSeriesItems")
    func removeDuplicates_1() throws {
        let sequence: [MocItem] = [
            MocItem(time: 0, index: 0),
            MocItem(time: 0, index: 0),

            MocItem(time: 50, index: 5),
            MocItem(time: 50, index: 5),

            MocItem(time: 80, index: 8),
        ]

        let expected: [MocItem] = [
            MocItem(time: 0, index: 0),
            MocItem(time: 50, index: 5),
            MocItem(time: 80, index: 8),
        ]

        #expect(expected == Array(sequence.removeDuplicates()))
    }

    @Test("Time remove duplicates")
    func sequenceRemoveDuplicates_2() throws {
        let sequence: [MocItem] = [
            MocItem(time: 0, index: 0),
        ]

        let expected: [MocItem] = [
            MocItem(time: 0, index: 0),
        ]

        #expect(expected == Array(sequence.removeDuplicates()))
    }
}
