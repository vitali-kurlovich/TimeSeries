//
//  Range+FixedDate.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 27.01.25.
//

public
extension Range where Bound == FixedDate {
    func intersects(_ range: Range<FixedDate>) -> Bool {
        intersects(range.lowerBound...) && intersects(..<range.upperBound)
    }

    func intersects(_ range: ClosedRange<FixedDate>) -> Bool {
        intersects(range.lowerBound...) && intersects(...range.upperBound)
    }

    func intersects(_ range: PartialRangeFrom<FixedDate>) -> Bool {
        return range.lowerBound < upperBound
    }

    func intersects(_ range: PartialRangeThrough<FixedDate>) -> Bool {
        return lowerBound <= range.upperBound
    }

    func intersects(_ range: PartialRangeUpTo<FixedDate>) -> Bool {
        return lowerBound < range.upperBound
    }
}

public
extension ClosedRange where Bound == FixedDate {
    func intersects(_ range: Range<FixedDate>) -> Bool {
        intersects(range.lowerBound...) && intersects(..<range.upperBound)
    }

    func intersects(_ range: ClosedRange<FixedDate>) -> Bool {
        intersects(range.lowerBound...) && intersects(...range.upperBound)
    }

    func intersects(_ range: PartialRangeFrom<FixedDate>) -> Bool {
        return range.lowerBound <= upperBound
    }

    func intersects(_ range: PartialRangeThrough<FixedDate>) -> Bool {
        return lowerBound <= range.upperBound
    }

    func intersects(_ range: PartialRangeUpTo<FixedDate>) -> Bool {
        return lowerBound < range.upperBound
    }
}

public
extension PartialRangeFrom where Bound == FixedDate {
    func intersects(_ range: Range<FixedDate>) -> Bool {
        intersects(range.lowerBound...) && intersects(..<range.upperBound)
    }

    func intersects(_ range: ClosedRange<FixedDate>) -> Bool {
        intersects(range.lowerBound...) && intersects(...range.upperBound)
    }

    func intersects(_: PartialRangeFrom<FixedDate>) -> Bool {
        return true
    }

    func intersects(_ range: PartialRangeThrough<FixedDate>) -> Bool {
        return lowerBound <= range.upperBound
    }

    func intersects(_ range: PartialRangeUpTo<FixedDate>) -> Bool {
        return lowerBound < range.upperBound
    }
}

public
extension PartialRangeThrough where Bound == FixedDate {
    func intersects(_ range: Range<FixedDate>) -> Bool {
        intersects(range.lowerBound...) && intersects(..<range.upperBound)
    }

    func intersects(_ range: ClosedRange<FixedDate>) -> Bool {
        intersects(range.lowerBound...) && intersects(...range.upperBound)
    }

    func intersects(_ range: PartialRangeFrom<FixedDate>) -> Bool {
        return range.lowerBound <= upperBound
    }

    func intersects(_: PartialRangeThrough<FixedDate>) -> Bool {
        return true
    }

    func intersects(_: PartialRangeUpTo<FixedDate>) -> Bool {
        return true
    }
}

public
extension PartialRangeUpTo where Bound == FixedDate {
    func intersects(_ range: Range<FixedDate>) -> Bool {
        intersects(range.lowerBound...) && intersects(..<range.upperBound)
    }

    func intersects(_ range: ClosedRange<FixedDate>) -> Bool {
        intersects(range.lowerBound...) && intersects(...range.upperBound)
    }

    func intersects(_ range: PartialRangeFrom<FixedDate>) -> Bool {
        return range.lowerBound < upperBound
    }

    func intersects(_: PartialRangeThrough<FixedDate>) -> Bool {
        return true
    }

    func intersects(_: PartialRangeUpTo<FixedDate>) -> Bool {
        return true
    }
}
