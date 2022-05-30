/************************************************************************
 *     PROJECT: RegularExpression
 *    FILENAME: Extensions.swift
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 2/11/21
 *
 * Copyright © 2021 Galen Rhodes. All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 ***************************************************************************/

import Foundation
import CoreFoundation

extension RegularExpression {

    @inlinable func toStringAndRange<S>(str: S) -> (String, Range<String.Index>) where S: StringProtocol {
        let _str = ((str as? String) ?? String(str))
        return (_str, (_str.startIndex ..< _str.endIndex))
    }

    /*===========================================================================================================================================================================*/
    /// These constants define the regular expression options. These constants are used by `init(pattern:options:)`.
    ///
    public struct Options: OptionSet {
        /*=======================================================================================================================================================================*/
        /// All matches are case-insensitive.
        ///
        public static let caseInsensitive:            Options = Options(rawValue: 1 << 0)
        /*=======================================================================================================================================================================*/
        /// Ignore whitespace and #-prefixed comments in the pattern.
        ///
        public static let allowCommentsAndWhitespace: Options = Options(rawValue: 1 << 1)
        /*=======================================================================================================================================================================*/
        /// Treat the entire pattern as a literal string.
        ///
        public static let ignoreMetacharacters:       Options = Options(rawValue: 1 << 2)
        /*=======================================================================================================================================================================*/
        /// Allow . to match any character, including line separators.
        ///
        public static let dotMatchesLineSeparators:   Options = Options(rawValue: 1 << 3)
        /*=======================================================================================================================================================================*/
        /// Allow ^ and $ to match the start and end of lines.
        ///
        public static let anchorsMatchLines:          Options = Options(rawValue: 1 << 4)
        /*=======================================================================================================================================================================*/
        /// Treat only \n as a line separator (otherwise, all standard line separators are used).
        ///
        public static let useUnixLineSeparators:      Options = Options(rawValue: 1 << 5)
        /*=======================================================================================================================================================================*/
        /// Use Unicode TR#29 to specify word boundaries (otherwise, traditional regular expression word boundaries are used).
        ///
        public static let useUnicodeWordBoundaries:   Options = Options(rawValue: 1 << 6)

        public let rawValue: UInt8

        public init(rawValue: UInt8) { self.rawValue = rawValue }

        @inlinable func convert() -> NSRegularExpression.Options {
            var o: NSRegularExpression.Options = []
            if contains(RegularExpression.Options.caseInsensitive) { o.insert(NSRegularExpression.Options.caseInsensitive) }
            if contains(RegularExpression.Options.allowCommentsAndWhitespace) { o.insert(NSRegularExpression.Options.allowCommentsAndWhitespace) }
            if contains(RegularExpression.Options.ignoreMetacharacters) { o.insert(NSRegularExpression.Options.ignoreMetacharacters) }
            if contains(RegularExpression.Options.dotMatchesLineSeparators) { o.insert(NSRegularExpression.Options.dotMatchesLineSeparators) }
            if contains(RegularExpression.Options.anchorsMatchLines) { o.insert(NSRegularExpression.Options.anchorsMatchLines) }
            if contains(RegularExpression.Options.useUnixLineSeparators) { o.insert(NSRegularExpression.Options.useUnixLineSeparators) }
            if contains(RegularExpression.Options.useUnicodeWordBoundaries) { o.insert(NSRegularExpression.Options.useUnicodeWordBoundaries) }
            return o
        }
    }

    /*===========================================================================================================================================================================*/
    /// The matching options constants specify the reporting, completion and matching rules to the expression matching methods. These constants are used by all methods that search
    /// for, or replace values, using a regular expression.
    ///
    public struct MatchingOptions: OptionSet {
        /*=======================================================================================================================================================================*/
        /// Call the Block periodically during long-running match operations. This option has no effect for methods other than `forEachMatch(in:options:range:using:)`. See
        /// `forEachMatch(in:options:range:using:)` for a description of the constant in context.
        ///
        public static let reportProgress:         MatchingOptions = MatchingOptions(rawValue: 1 << 0)
        /*=======================================================================================================================================================================*/
        /// Call the Block once after the completion of any matching. This option has no effect for methods other than `forEachMatch(in:options:range:using:)`. See
        /// `forEachMatch(in:options:range:using:)` for a description of the constant in context.
        ///
        public static let reportCompletion:       MatchingOptions = MatchingOptions(rawValue: 1 << 1)
        /*=======================================================================================================================================================================*/
        /// Specifies that matches are limited to those at the start of the search range. See `forEachMatch(in:options:range:using:)` for a description of the constant in context.
        ///
        public static let anchored:               MatchingOptions = MatchingOptions(rawValue: 1 << 2)
        /*=======================================================================================================================================================================*/
        /// Specifies that matching may examine parts of the string beyond the bounds of the search range, for purposes such as word boundary detection, lookahead, etc. This
        /// constant has no effect if the search range contains the entire string. See `forEachMatch(in:options:range:using:)` for a description of the constant in context.
        ///
        public static let withTransparentBounds:  MatchingOptions = MatchingOptions(rawValue: 1 << 3)
        /*=======================================================================================================================================================================*/
        /// Specifies that ^ and $ will not automatically match the beginning and end of the search range, but will still match the beginning and end of the entire string. This
        /// constant has no effect if the search range contains the entire string. See `forEachMatch(in:options:range:using:)` for a description of the constant in context.
        ///
        public static let withoutAnchoringBounds: MatchingOptions = MatchingOptions(rawValue: 1 << 4)

        public let rawValue: UInt8

        public init(rawValue: UInt8) { self.rawValue = rawValue }

        @inlinable func convert() -> NSRegularExpression.MatchingOptions {
            var o: NSRegularExpression.MatchingOptions = []
            if contains(RegularExpression.MatchingOptions.reportProgress) { o.insert(NSRegularExpression.MatchingOptions.reportProgress) }
            if contains(RegularExpression.MatchingOptions.reportCompletion) { o.insert(NSRegularExpression.MatchingOptions.reportCompletion) }
            if contains(RegularExpression.MatchingOptions.anchored) { o.insert(NSRegularExpression.MatchingOptions.anchored) }
            if contains(RegularExpression.MatchingOptions.withTransparentBounds) { o.insert(NSRegularExpression.MatchingOptions.withTransparentBounds) }
            if contains(RegularExpression.MatchingOptions.withoutAnchoringBounds) { o.insert(NSRegularExpression.MatchingOptions.withoutAnchoringBounds) }
            return o
        }
    }

    /*===========================================================================================================================================================================*/
    /// Set by the Block as the matching progresses, completes, or fails. Used by the method `forEachMatch(in:options:range:using:)`.
    ///
    public struct MatchingFlags: OptionSet {
        /*=======================================================================================================================================================================*/
        /// Set when the Block is called to report progress during a long-running match operation.
        ///
        public static let progress:      MatchingFlags = MatchingFlags(rawValue: 1 << 0)
        /*=======================================================================================================================================================================*/
        /// Set when the Block is called after matching has completed.
        ///
        public static let completed:     MatchingFlags = MatchingFlags(rawValue: 1 << 1)
        /*=======================================================================================================================================================================*/
        /// Set when the current match operation reached the end of the search range.
        ///
        public static let hitEnd:        MatchingFlags = MatchingFlags(rawValue: 1 << 2)
        /*=======================================================================================================================================================================*/
        /// Set when the current match depended on the location of the end of the search range.
        ///
        public static let requiredEnd:   MatchingFlags = MatchingFlags(rawValue: 1 << 3)
        /*=======================================================================================================================================================================*/
        /// Set when matching failed due to an internal error.
        ///
        public static let internalError: MatchingFlags = MatchingFlags(rawValue: 1 << 4)

        public let rawValue: UInt8

        public init(rawValue: UInt8) { self.rawValue = rawValue }
    }

    /*===========================================================================================================================================================================*/
    /// This class encapsulates all of the capture groups of a single match.
    ///
    public final class Match: Sequence, Collection {
        public typealias Element = Group
        public typealias Index = Int

        /*=======================================================================================================================================================================*/
        /// The search string.
        ///
        public let string:     String
        /*=======================================================================================================================================================================*/
        /// The index of the first capture group.
        ///
        public let startIndex: Index = 0
        /*=======================================================================================================================================================================*/
        /// The index just past the last capture group.
        ///
        public let endIndex:   Index
        /*=======================================================================================================================================================================*/
        /// The number of capture groups.
        ///
        public let count:      Int
        /*=======================================================================================================================================================================*/
        /// The range within the search string for the entire match.
        ///
        public let range:      Range<String.Index>
        /*=======================================================================================================================================================================*/
        /// The sub-string of the entire match region.
        ///
        public private(set) lazy var subString: String = String(string[range])

        @usableFromInline let nsMatch:    NSTextCheckingResult
        @usableFromInline var namedCache: [String: NamedGroup] = [:]

        @usableFromInline lazy var groups: [Group] = {
            var grps: [Group] = []
            for x in (0 ..< nsMatch.numberOfRanges) { grps.append(Group(string, range: nsMatch.range(at: x))) }
            return grps
        }()

        @inlinable init?(_ str: String, match: NSTextCheckingResult?) {
            guard let _match = match else { return nil }
            nsMatch = _match
            string = str
            endIndex = _match.numberOfRanges
            count = endIndex
            range = (Range<String.Index>(_match.range, in: str) ?? (str.startIndex ..< str.endIndex))
        }
    }

    /*===========================================================================================================================================================================*/
    /// This class encapsulates a single capture group.
    ///
    public class Group {
        @usableFromInline let rng: NSRange
        @usableFromInline let str: String

        /*=======================================================================================================================================================================*/
        /// The range of the search string for this capture group of `nil` if this capture group did not participate in the match.
        ///
        public private(set) lazy var range: Range<String.Index>? = ((rng.location == NSNotFound) ? nil : Range<String.Index>(rng, in: str))
        /*=======================================================================================================================================================================*/
        /// The substring of the search string for this capture group of `nil` if this capture group did not participate in the match.
        ///
        public private(set) lazy var subString: String? = {
            guard let r = range else { return nil }
            return String(str[r])
        }()

        @usableFromInline init(_ string: String, range: NSRange) {
            str = string
            rng = range
        }
    }

    /*===========================================================================================================================================================================*/
    /// This class encapsulates a single named capture group.
    ///
    public class NamedGroup: Group {
        /*=======================================================================================================================================================================*/
        /// The name of the capture group.
        ///
        public let name: String

        @usableFromInline init(_ string: String, name: String, range: NSRange) {
            self.name = name
            super.init(string, range: range)
        }
    }
}

extension RegularExpression.Match {
    /*===========================================================================================================================================================================*/
    /// Returns a named capture group.
    /// 
    /// - Parameter name: the name of the capture group
    /// - Returns: the named capture group or `nil` if the capture group does not exist.
    ///
    @inlinable public subscript(name: String) -> RegularExpression.NamedGroup? {
        if let ng = namedCache[name] { return ng }
        let range = nsMatch.range(withName: name)
        guard range.location != NSNotFound else { return nil }
        let ng = RegularExpression.NamedGroup(string, name: name, range: range)
        namedCache[name] = ng
        return ng
    }

    /*===========================================================================================================================================================================*/
    /// Returns the capture group for the given index.
    /// 
    /// - Parameter position: the index which must be between `startIndex` <= index < `endIndex`.
    /// - Returns: the capture group.
    ///
    @inlinable public subscript(position: Index) -> Element { groups[position] }

    /*===========================================================================================================================================================================*/
    /// The index after the one given.
    /// 
    /// - Parameter i: the index.
    /// - Returns: the next index.
    ///
    @inlinable public func index(after i: Index) -> Index { groups.index(after: i) }

    /*===========================================================================================================================================================================*/
    /// Returns an iterator over all the capture groups.
    /// 
    /// - Returns: an iterator.
    ///
    @inlinable public func makeIterator() -> Iterator { Iterator(match: self) }

    /*===========================================================================================================================================================================*/
    /// The iterator class.
    ///
    public struct Iterator: IteratorProtocol {
        public typealias Element = RegularExpression.Group

        @usableFromInline var index:    Int
        @usableFromInline let endIndex: Int
        @usableFromInline let groups:   [Element]

        @inlinable init(match: RegularExpression.Match) {
            index = match.startIndex
            endIndex = match.endIndex
            groups = match.groups
        }

        /*=======================================================================================================================================================================*/
        /// Get the next element.
        /// 
        /// - Returns: the next element or `nil` if there are no more elements.
        ///
        @inlinable public mutating func next() -> Element? {
            guard index < endIndex else { return nil }
            let e = groups[index]
            index += 1
            return e
        }
    }
}

extension NSRegularExpression.Options {
    @inlinable func convert() -> RegularExpression.Options {
        var o: RegularExpression.Options = []
        if contains(NSRegularExpression.Options.caseInsensitive) { o.insert(RegularExpression.Options.caseInsensitive) }
        if contains(NSRegularExpression.Options.allowCommentsAndWhitespace) { o.insert(RegularExpression.Options.allowCommentsAndWhitespace) }
        if contains(NSRegularExpression.Options.ignoreMetacharacters) { o.insert(RegularExpression.Options.ignoreMetacharacters) }
        if contains(NSRegularExpression.Options.dotMatchesLineSeparators) { o.insert(RegularExpression.Options.dotMatchesLineSeparators) }
        if contains(NSRegularExpression.Options.anchorsMatchLines) { o.insert(RegularExpression.Options.anchorsMatchLines) }
        if contains(NSRegularExpression.Options.useUnixLineSeparators) { o.insert(RegularExpression.Options.useUnixLineSeparators) }
        if contains(NSRegularExpression.Options.useUnicodeWordBoundaries) { o.insert(RegularExpression.Options.useUnicodeWordBoundaries) }
        return o
    }
}

extension NSRegularExpression.MatchingFlags {
    @inlinable func convert() -> RegularExpression.MatchingFlags {
        var o: RegularExpression.MatchingFlags = []
        if contains(NSRegularExpression.MatchingFlags.progress) { o.insert(RegularExpression.MatchingFlags.progress) }
        if contains(NSRegularExpression.MatchingFlags.completed) { o.insert(RegularExpression.MatchingFlags.completed) }
        if contains(NSRegularExpression.MatchingFlags.hitEnd) { o.insert(RegularExpression.MatchingFlags.hitEnd) }
        if contains(NSRegularExpression.MatchingFlags.requiredEnd) { o.insert(RegularExpression.MatchingFlags.requiredEnd) }
        if contains(NSRegularExpression.MatchingFlags.internalError) { o.insert(RegularExpression.MatchingFlags.internalError) }
        return o
    }
}
