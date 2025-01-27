//
//  RangeFixedDateTests.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 27.01.25.
//

import Testing
@testable import TimeSeries

enum FixedDateIntersectionTests {}

extension FixedDateIntersectionTests {
    @Suite("Range")
    struct RangeIntersection {
        @Test("Range with Range", arguments: [
            (range: FixedDate(200) ..< FixedDate(400), target: FixedDate(100) ..< FixedDate(500), expected: true),
            (range: FixedDate(200) ..< FixedDate(400), target: FixedDate(200) ..< FixedDate(400), expected: true),
            (range: FixedDate(200) ..< FixedDate(400), target: FixedDate(250) ..< FixedDate(400), expected: true),
            (range: FixedDate(200) ..< FixedDate(400), target: FixedDate(100) ..< FixedDate(250), expected: true),

            (range: FixedDate(200) ..< FixedDate(400), target: FixedDate(100) ..< FixedDate(150), expected: false),
            (range: FixedDate(200) ..< FixedDate(400), target: FixedDate(450) ..< FixedDate(500), expected: false),
            (range: FixedDate(200) ..< FixedDate(400), target: FixedDate(100) ..< FixedDate(200), expected: false),
            (range: FixedDate(200) ..< FixedDate(400), target: FixedDate(400) ..< FixedDate(500), expected: false),
        ])
        func range(_ test: (range: Range<FixedDate>, target: Range<FixedDate>, expected: Bool)) {
            #expect(test.range.intersects(test.target) == test.expected)
            #expect(test.target.intersects(test.range) == test.expected)
        }

        @Test("Range with ClosedRange", arguments: [
            (range: FixedDate(200) ..< FixedDate(400), target: FixedDate(100) ... FixedDate(500), expected: true),
            (range: FixedDate(200) ..< FixedDate(400), target: FixedDate(200) ... FixedDate(400), expected: true),
            (range: FixedDate(200) ..< FixedDate(400), target: FixedDate(250) ... FixedDate(400), expected: true),
            (range: FixedDate(200) ..< FixedDate(400), target: FixedDate(100) ... FixedDate(250), expected: true),

            (range: FixedDate(200) ..< FixedDate(400), target: FixedDate(100) ... FixedDate(200), expected: true),

            (range: FixedDate(200) ..< FixedDate(400), target: FixedDate(400) ... FixedDate(500), expected: false),
            (range: FixedDate(200) ..< FixedDate(400), target: FixedDate(100) ... FixedDate(150), expected: false),
            (range: FixedDate(200) ..< FixedDate(400), target: FixedDate(450) ... FixedDate(500), expected: false),

        ])
        func range(_ test: (range: Range<FixedDate>, target: ClosedRange<FixedDate>, expected: Bool)) {
            #expect(test.range.intersects(test.target) == test.expected)
            #expect(test.target.intersects(test.range) == test.expected)
        }

        @Test("Range with PartialRangeFrom", arguments: [
            (range: FixedDate(200) ..< FixedDate(400), target: FixedDate(100)..., expected: true),
            (range: FixedDate(200) ..< FixedDate(400), target: FixedDate(200)..., expected: true),
            (range: FixedDate(200) ..< FixedDate(400), target: FixedDate(250)..., expected: true),

            (range: FixedDate(200) ..< FixedDate(400), target: FixedDate(400)..., expected: false),
            (range: FixedDate(200) ..< FixedDate(400), target: FixedDate(450)..., expected: false),
        ])
        func range(_ test: (range: Range<FixedDate>, target: PartialRangeFrom<FixedDate>, expected: Bool)) {
            #expect(test.range.intersects(test.target) == test.expected)
            #expect(test.target.intersects(test.range) == test.expected)
        }

        @Test("Range with PartialRangeThrough", arguments: [
            (range: FixedDate(200) ..< FixedDate(400), target: ...FixedDate(500), expected: true),
            (range: FixedDate(200) ..< FixedDate(400), target: ...FixedDate(400), expected: true),
            (range: FixedDate(200) ..< FixedDate(400), target: ...FixedDate(250), expected: true),
            (range: FixedDate(200) ..< FixedDate(400), target: ...FixedDate(200), expected: true),

            (range: FixedDate(200) ..< FixedDate(400), target: ...FixedDate(100), expected: false),
        ])
        func range(_ test: (range: Range<FixedDate>, target: PartialRangeThrough<FixedDate>, expected: Bool)) {
            #expect(test.range.intersects(test.target) == test.expected)
            #expect(test.target.intersects(test.range) == test.expected)
        }

        @Test("Range with PartialRangeUpTo", arguments: [
            (range: FixedDate(200) ..< FixedDate(400), target: ..<FixedDate(500), expected: true),
            (range: FixedDate(200) ..< FixedDate(400), target: ..<FixedDate(400), expected: true),
            (range: FixedDate(200) ..< FixedDate(400), target: ..<FixedDate(250), expected: true),

            (range: FixedDate(200) ..< FixedDate(400), target: ..<FixedDate(200), expected: false),
            (range: FixedDate(200) ..< FixedDate(400), target: ..<FixedDate(100), expected: false),
        ])
        func range(_ test: (range: Range<FixedDate>, target: PartialRangeUpTo<FixedDate>, expected: Bool)) {
            #expect(test.range.intersects(test.target) == test.expected)
            #expect(test.target.intersects(test.range) == test.expected)
        }
    }
    //
}

extension FixedDateIntersectionTests {
    @Suite("CloseRange")
    struct CloseRangeIntersection {
        @Test("ClosedRange with Range", arguments: [
            (range: FixedDate(200) ... FixedDate(400), target: FixedDate(100) ..< FixedDate(500), expected: true),
            (range: FixedDate(200) ... FixedDate(400), target: FixedDate(200) ..< FixedDate(400), expected: true),
            (range: FixedDate(200) ... FixedDate(400), target: FixedDate(250) ..< FixedDate(400), expected: true),
            (range: FixedDate(200) ... FixedDate(400), target: FixedDate(100) ..< FixedDate(250), expected: true),
            (range: FixedDate(200) ... FixedDate(400), target: FixedDate(400) ..< FixedDate(500), expected: true),

            (range: FixedDate(200) ... FixedDate(400), target: FixedDate(100) ..< FixedDate(150), expected: false),
            (range: FixedDate(200) ... FixedDate(400), target: FixedDate(450) ..< FixedDate(500), expected: false),
            (range: FixedDate(200) ... FixedDate(400), target: FixedDate(100) ..< FixedDate(200), expected: false),

        ])
        func range(_ test: (range: ClosedRange<FixedDate>, target: Range<FixedDate>, expected: Bool)) {
            #expect(test.range.intersects(test.target) == test.expected)
            #expect(test.target.intersects(test.range) == test.expected)
        }

        @Test("ClosedRange with ClosedRange", arguments: [
            (range: FixedDate(200) ... FixedDate(400), target: FixedDate(100) ... FixedDate(500), expected: true),
            (range: FixedDate(200) ... FixedDate(400), target: FixedDate(200) ... FixedDate(400), expected: true),
            (range: FixedDate(200) ... FixedDate(400), target: FixedDate(250) ... FixedDate(400), expected: true),
            (range: FixedDate(200) ... FixedDate(400), target: FixedDate(100) ... FixedDate(250), expected: true),
            (range: FixedDate(200) ... FixedDate(400), target: FixedDate(100) ... FixedDate(200), expected: true),
            (range: FixedDate(200) ... FixedDate(400), target: FixedDate(400) ... FixedDate(500), expected: true),

            (range: FixedDate(200) ... FixedDate(400), target: FixedDate(100) ... FixedDate(150), expected: false),
            (range: FixedDate(200) ... FixedDate(400), target: FixedDate(450) ... FixedDate(500), expected: false),

        ])
        func range(_ test: (range: ClosedRange<FixedDate>, target: ClosedRange<FixedDate>, expected: Bool)) {
            #expect(test.range.intersects(test.target) == test.expected)
            #expect(test.target.intersects(test.range) == test.expected)
        }

        @Test("ClosedRange with PartialRangeFrom", arguments: [
            (range: FixedDate(200) ... FixedDate(400), target: FixedDate(100)..., expected: true),
            (range: FixedDate(200) ... FixedDate(400), target: FixedDate(200)..., expected: true),
            (range: FixedDate(200) ... FixedDate(400), target: FixedDate(250)..., expected: true),
            (range: FixedDate(200) ... FixedDate(400), target: FixedDate(400)..., expected: true),

            (range: FixedDate(200) ... FixedDate(400), target: FixedDate(450)..., expected: false),
        ])
        func range(_ test: (range: ClosedRange<FixedDate>, target: PartialRangeFrom<FixedDate>, expected: Bool)) {
            #expect(test.range.intersects(test.target) == test.expected)
            #expect(test.target.intersects(test.range) == test.expected)
        }

        @Test("ClosedRange with PartialRangeThrough", arguments: [
            (range: FixedDate(200) ... FixedDate(400), target: ...FixedDate(500), expected: true),
            (range: FixedDate(200) ... FixedDate(400), target: ...FixedDate(400), expected: true),
            (range: FixedDate(200) ... FixedDate(400), target: ...FixedDate(250), expected: true),
            (range: FixedDate(200) ... FixedDate(400), target: ...FixedDate(200), expected: true),

            (range: FixedDate(200) ... FixedDate(400), target: ...FixedDate(100), expected: false),
        ])
        func range(_ test: (range: ClosedRange<FixedDate>, target: PartialRangeThrough<FixedDate>, expected: Bool)) {
            #expect(test.range.intersects(test.target) == test.expected)
            #expect(test.target.intersects(test.range) == test.expected)
        }

        @Test("ClosedRange with PartialRangeUpTo", arguments: [
            (range: FixedDate(200) ... FixedDate(400), target: ..<FixedDate(500), expected: true),
            (range: FixedDate(200) ... FixedDate(400), target: ..<FixedDate(400), expected: true),
            (range: FixedDate(200) ... FixedDate(400), target: ..<FixedDate(250), expected: true),

            (range: FixedDate(200) ... FixedDate(400), target: ..<FixedDate(200), expected: false),
            (range: FixedDate(200) ... FixedDate(400), target: ..<FixedDate(100), expected: false),
        ])
        func range(_ test: (range: ClosedRange<FixedDate>, target: PartialRangeUpTo<FixedDate>, expected: Bool)) {
            #expect(test.range.intersects(test.target) == test.expected)
            #expect(test.target.intersects(test.range) == test.expected)
        }
    }
}

extension FixedDateIntersectionTests {
    @Suite("PartialRangeFrom")
    struct PartialRangeFromIntersection {
        @Test("PartialRangeFrom with Range", arguments: [
            (range: FixedDate(200)..., target: FixedDate(100) ..< FixedDate(500), expected: true),
            (range: FixedDate(200)..., target: FixedDate(200) ..< FixedDate(400), expected: true),
            (range: FixedDate(200)..., target: FixedDate(250) ..< FixedDate(400), expected: true),
            (range: FixedDate(200)..., target: FixedDate(100) ..< FixedDate(250), expected: true),
            (range: FixedDate(200)..., target: FixedDate(400) ..< FixedDate(500), expected: true),

            (range: FixedDate(200)..., target: FixedDate(100) ..< FixedDate(150), expected: false),
            (range: FixedDate(200)..., target: FixedDate(100) ..< FixedDate(200), expected: false),

        ])
        func range(_ test: (range: PartialRangeFrom<FixedDate>, target: Range<FixedDate>, expected: Bool)) {
            #expect(test.range.intersects(test.target) == test.expected)
            #expect(test.target.intersects(test.range) == test.expected)
        }

        @Test("PartialRangeFrom with ClosedRange", arguments: [
            (range: FixedDate(200)..., target: FixedDate(100) ... FixedDate(500), expected: true),
            (range: FixedDate(200)..., target: FixedDate(200) ... FixedDate(400), expected: true),
            (range: FixedDate(200)..., target: FixedDate(250) ... FixedDate(400), expected: true),
            (range: FixedDate(200)..., target: FixedDate(100) ... FixedDate(250), expected: true),
            (range: FixedDate(200)..., target: FixedDate(100) ... FixedDate(200), expected: true),
            (range: FixedDate(200)..., target: FixedDate(400) ... FixedDate(500), expected: true),

            (range: FixedDate(200)..., target: FixedDate(100) ... FixedDate(150), expected: false),
        ])
        func range(_ test: (range: PartialRangeFrom<FixedDate>, target: ClosedRange<FixedDate>, expected: Bool)) {
            #expect(test.range.intersects(test.target) == test.expected)
            #expect(test.target.intersects(test.range) == test.expected)
        }

        @Test("PartialRangeFrom with PartialRangeFrom", arguments: [
            (range: FixedDate(200)..., target: FixedDate(100)..., expected: true),
            (range: FixedDate(200)..., target: FixedDate(200)..., expected: true),
            (range: FixedDate(200)..., target: FixedDate(250)..., expected: true),
            (range: FixedDate(200)..., target: FixedDate(400)..., expected: true),

            (range: FixedDate(200)..., target: FixedDate(450)..., expected: true),
        ])
        func range(_ test: (range: PartialRangeFrom<FixedDate>, target: PartialRangeFrom<FixedDate>, expected: Bool)) {
            #expect(test.range.intersects(test.target) == test.expected)
            #expect(test.target.intersects(test.range) == test.expected)
        }

        @Test("PartialRangeFrom with PartialRangeThrough", arguments: [
            (range: FixedDate(200)..., target: ...FixedDate(500), expected: true),
            (range: FixedDate(200)..., target: ...FixedDate(400), expected: true),
            (range: FixedDate(200)..., target: ...FixedDate(250), expected: true),
            (range: FixedDate(200)..., target: ...FixedDate(200), expected: true),

            (range: FixedDate(200)..., target: ...FixedDate(100), expected: false),
        ])
        func range(_ test: (range: PartialRangeFrom<FixedDate>, target: PartialRangeThrough<FixedDate>, expected: Bool)) {
            #expect(test.range.intersects(test.target) == test.expected)
            #expect(test.target.intersects(test.range) == test.expected)
        }

        @Test("PartialRangeFrom with PartialRangeUpTo", arguments: [
            (range: FixedDate(200)..., target: ..<FixedDate(500), expected: true),
            (range: FixedDate(200)..., target: ..<FixedDate(400), expected: true),
            (range: FixedDate(200)..., target: ..<FixedDate(250), expected: true),

            (range: FixedDate(200)..., target: ..<FixedDate(200), expected: false),
            (range: FixedDate(200)..., target: ..<FixedDate(100), expected: false),
        ])
        func range(_ test: (range: PartialRangeFrom<FixedDate>, target: PartialRangeUpTo<FixedDate>, expected: Bool)) {
            #expect(test.range.intersects(test.target) == test.expected)
            #expect(test.target.intersects(test.range) == test.expected)
        }
    }
}

extension FixedDateIntersectionTests {
    @Suite("PartialRangeThrough")
    struct PartialRangeThroughIntersection {
        @Test("PartialRangeThrough with Range", arguments: [
            (range: ...FixedDate(400), target: FixedDate(100) ..< FixedDate(200), expected: true),
            (range: ...FixedDate(400), target: FixedDate(100) ..< FixedDate(500), expected: true),
            (range: ...FixedDate(400), target: FixedDate(200) ..< FixedDate(400), expected: true),
            (range: ...FixedDate(400), target: FixedDate(250) ..< FixedDate(400), expected: true),
            (range: ...FixedDate(400), target: FixedDate(100) ..< FixedDate(250), expected: true),
            (range: ...FixedDate(400), target: FixedDate(400) ..< FixedDate(500), expected: true),
            (range: ...FixedDate(400), target: FixedDate(100) ..< FixedDate(400), expected: true),

            (range: ...FixedDate(400), target: FixedDate(450) ..< FixedDate(500), expected: false),
        ])
        func range(_ test: (range: PartialRangeThrough<FixedDate>, target: Range<FixedDate>, expected: Bool)) {
            #expect(test.range.intersects(test.target) == test.expected)
            #expect(test.target.intersects(test.range) == test.expected)
        }

        @Test("PartialRangeThrough with ClosedRange", arguments: [
            (range: ...FixedDate(400), target: FixedDate(100) ... FixedDate(150), expected: true),
            (range: ...FixedDate(400), target: FixedDate(100) ... FixedDate(500), expected: true),
            (range: ...FixedDate(400), target: FixedDate(200) ... FixedDate(400), expected: true),
            (range: ...FixedDate(400), target: FixedDate(250) ... FixedDate(400), expected: true),
            (range: ...FixedDate(400), target: FixedDate(100) ... FixedDate(250), expected: true),
            (range: ...FixedDate(400), target: FixedDate(100) ... FixedDate(200), expected: true),
            (range: ...FixedDate(400), target: FixedDate(400) ... FixedDate(500), expected: true),

            (range: ...FixedDate(400), target: FixedDate(450) ... FixedDate(500), expected: false),
        ])
        func range(_ test: (range: PartialRangeThrough<FixedDate>, target: ClosedRange<FixedDate>, expected: Bool)) {
            #expect(test.range.intersects(test.target) == test.expected)
            #expect(test.target.intersects(test.range) == test.expected)
        }

        @Test("PartialRangeThrough with PartialRangeFrom", arguments: [
            (range: ...FixedDate(400), target: FixedDate(100)..., expected: true),
            (range: ...FixedDate(400), target: FixedDate(200)..., expected: true),
            (range: ...FixedDate(400), target: FixedDate(250)..., expected: true),
            (range: ...FixedDate(400), target: FixedDate(400)..., expected: true),

            (range: ...FixedDate(400), target: FixedDate(450)..., expected: false),
        ])
        func range(_ test: (range: PartialRangeThrough<FixedDate>, target: PartialRangeFrom<FixedDate>, expected: Bool)) {
            #expect(test.range.intersects(test.target) == test.expected)
            #expect(test.target.intersects(test.range) == test.expected)
        }

        @Test("PartialRangeThrough with PartialRangeThrough", arguments: [
            (range: ...FixedDate(400), target: ...FixedDate(500), expected: true),
            (range: ...FixedDate(400), target: ...FixedDate(400), expected: true),
            (range: ...FixedDate(400), target: ...FixedDate(100), expected: true),
        ])
        func range(_ test: (range: PartialRangeThrough<FixedDate>, target: PartialRangeThrough<FixedDate>, expected: Bool)) {
            #expect(test.range.intersects(test.target) == test.expected)
            #expect(test.target.intersects(test.range) == test.expected)
        }

        @Test("PartialRangeThrough with PartialRangeUpTo", arguments: [
            (range: ...FixedDate(400), target: ..<FixedDate(500), expected: true),
            (range: ...FixedDate(400), target: ..<FixedDate(400), expected: true),
            (range: ...FixedDate(400), target: ..<FixedDate(400), expected: true),
            (range: ...FixedDate(400), target: ..<FixedDate(100), expected: true),
        ])
        func range(_ test: (range: PartialRangeThrough<FixedDate>, target: PartialRangeUpTo<FixedDate>, expected: Bool)) {
            #expect(test.range.intersects(test.target) == test.expected)
            #expect(test.target.intersects(test.range) == test.expected)
        }
    }
}

extension FixedDateIntersectionTests {
    @Suite("PartialRangeUpTo")
    struct PartialRangeUpToIntersection {
        @Test("PartialRangeUpTo with Range", arguments: [
            (range: ..<FixedDate(400), target: FixedDate(100) ..< FixedDate(200), expected: true),
            (range: ..<FixedDate(400), target: FixedDate(100) ..< FixedDate(500), expected: true),
            (range: ..<FixedDate(400), target: FixedDate(200) ..< FixedDate(400), expected: true),
            (range: ..<FixedDate(400), target: FixedDate(250) ..< FixedDate(400), expected: true),
            (range: ..<FixedDate(400), target: FixedDate(100) ..< FixedDate(250), expected: true),
            (range: ..<FixedDate(400), target: FixedDate(100) ..< FixedDate(400), expected: true),

            (range: ..<FixedDate(400), target: FixedDate(400) ..< FixedDate(500), expected: false),
            (range: ..<FixedDate(400), target: FixedDate(450) ..< FixedDate(500), expected: false),
        ])
        func range(_ test: (range: PartialRangeUpTo<FixedDate>, target: Range<FixedDate>, expected: Bool)) {
            #expect(test.range.intersects(test.target) == test.expected)
            #expect(test.target.intersects(test.range) == test.expected)
        }

        @Test("PartialRangeUpTo with ClosedRange", arguments: [
            (range: ..<FixedDate(400), target: FixedDate(100) ... FixedDate(150), expected: true),
            (range: ..<FixedDate(400), target: FixedDate(100) ... FixedDate(500), expected: true),
            (range: ..<FixedDate(400), target: FixedDate(200) ... FixedDate(400), expected: true),
            (range: ..<FixedDate(400), target: FixedDate(250) ... FixedDate(400), expected: true),
            (range: ..<FixedDate(400), target: FixedDate(100) ... FixedDate(250), expected: true),
            (range: ..<FixedDate(400), target: FixedDate(100) ... FixedDate(200), expected: true),

            (range: ..<FixedDate(400), target: FixedDate(400) ... FixedDate(500), expected: false),
            (range: ..<FixedDate(400), target: FixedDate(450) ... FixedDate(500), expected: false),
        ])
        func range(_ test: (range: PartialRangeUpTo<FixedDate>, target: ClosedRange<FixedDate>, expected: Bool)) {
            #expect(test.range.intersects(test.target) == test.expected)
            #expect(test.target.intersects(test.range) == test.expected)
        }

        @Test("PartialRangeUpTo with PartialRangeFrom", arguments: [
            (range: ..<FixedDate(400), target: FixedDate(100)..., expected: true),
            (range: ..<FixedDate(400), target: FixedDate(200)..., expected: true),
            (range: ..<FixedDate(400), target: FixedDate(250)..., expected: true),

            (range: ..<FixedDate(400), target: FixedDate(400)..., expected: false),
            (range: ..<FixedDate(400), target: FixedDate(450)..., expected: false),
        ])
        func range(_ test: (range: PartialRangeUpTo<FixedDate>, target: PartialRangeFrom<FixedDate>, expected: Bool)) {
            #expect(test.range.intersects(test.target) == test.expected)
            #expect(test.target.intersects(test.range) == test.expected)
        }

        @Test("PartialRangeUpTo with PartialRangeThrough", arguments: [
            (range: ..<FixedDate(400), target: ...FixedDate(500), expected: true),
            (range: ..<FixedDate(400), target: ...FixedDate(400), expected: true),
            (range: ..<FixedDate(400), target: ...FixedDate(100), expected: true),
        ])
        func range(_ test: (range: PartialRangeUpTo<FixedDate>, target: PartialRangeThrough<FixedDate>, expected: Bool)) {
            #expect(test.range.intersects(test.target) == test.expected)
            #expect(test.target.intersects(test.range) == test.expected)
        }

        @Test("PartialRangeUpTo with PartialRangeUpTo", arguments: [
            (range: ..<FixedDate(400), target: ..<FixedDate(500), expected: true),
            (range: ..<FixedDate(400), target: ..<FixedDate(400), expected: true),
            (range: ..<FixedDate(400), target: ..<FixedDate(400), expected: true),
            (range: ..<FixedDate(400), target: ..<FixedDate(100), expected: true),
        ])
        func range(_ test: (range: PartialRangeUpTo<FixedDate>, target: PartialRangeUpTo<FixedDate>, expected: Bool)) {
            #expect(test.range.intersects(test.target) == test.expected)
            #expect(test.target.intersects(test.range) == test.expected)
        }
    }
}
