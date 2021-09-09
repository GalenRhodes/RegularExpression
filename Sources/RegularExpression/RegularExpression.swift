/************************************************************************//**
 *     PROJECT: Rubicon
 *    FILENAME: RegularExpression.swift
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 1/19/21
 *
 * Copyright © 2021 Project Galen. All rights reserved.
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
 *//************************************************************************/

import Foundation
import CoreFoundation

/*===============================================================================================================================================================================*/
/// See <code>[NSRegularExpression](https://developer.apple.com/documentation/foundation/NSRegularExpression)</code> for details on pattern syntax.
///
open class RegularExpression {

    /*===========================================================================================================================================================================*/
    /// The options specified during creation.
    ///
    public let options: Options
    /*===========================================================================================================================================================================*/
    /// The pattern specified during creation.
    ///
    public private(set) lazy var pattern:               String = nsRegex.pattern
    /*===========================================================================================================================================================================*/
    /// The number of capture groups in the pattern.
    ///
    public private(set) lazy var numberOfCaptureGroups: Int    = nsRegex.numberOfCaptureGroups
    /*===========================================================================================================================================================================*/
    /// The underlying instance of <code>[NSRegularExpression](https://developer.apple.com/documentation/foundation/NSRegularExpression)</code>.
    ///
    @usableFromInline let nsRegex: NSRegularExpression

    /*===========================================================================================================================================================================*/
    /// Returns an initialized `RegularExpression` instance with the specified regular expression pattern and options. If an error occurs then `nil` is returned.
    /// 
    /// See <code>[NSRegularExpression](https://developer.apple.com/documentation/foundation/NSRegularExpression)</code> for details on pattern syntax.
    /// 
    /// - Parameters:
    ///   - pattern: the regular expression pattern.
    ///   - options: the options.
    ///   - error: if initialization fails then this parameter will be set to the error.
    ///
    public init?<S>(pattern: S, options: Options = [], error: inout Error?) where S: StringProtocol {
        do {
            self.options = options
            nsRegex = try NSRegularExpression(pattern: ((pattern as? String) ?? String(pattern)), options: options.convert())
        }
        catch let e {
            error = e
            return nil
        }
    }
}

extension RegularExpression {
    /*===========================================================================================================================================================================*/
    /// Returns an initialized `RegularExpression` instance with the specified regular expression pattern and options. If an error occurs then `nil` is returned.
    /// 
    /// - Parameters:
    ///   - pattern: the regular expression pattern.
    ///   - options: the options.
    ///
    @inlinable public convenience init?<S>(pattern: S, options: Options = []) where S: StringProtocol {
        var e: Error? = nil
        self.init(pattern: pattern, options: options, error: &e)
    }

    /*===========================================================================================================================================================================*/
    /// Returns a string by adding backslash escapes as necessary to protect any characters that would match as pattern metacharacters.
    /// 
    /// Returns a string by adding backslash escapes as necessary to the given string, to escape any characters that would otherwise be treated as pattern metacharacters. You
    /// typically use this method to match on a particular string within a larger pattern.
    /// 
    /// For example, the string "(N/A)" contains the pattern metacharacters (, /, and ). The result of adding backslash escapes to this string is "\\(N\\/A\\)".
    /// 
    /// - Parameter string: the string or substring.
    /// - Returns: the escaped string.
    ///
    @inlinable public class func escapedPattern<S>(for string: S) -> String where S: StringProtocol { NSRegularExpression.escapedPattern(for: ((string as? String) ?? String(string))) }

    /*===========================================================================================================================================================================*/
    /// Returns a template string by adding backslash escapes as necessary to protect any characters that would match as pattern metacharacters
    /// 
    /// Returns a string by adding backslash escapes as necessary to the given string, to escape any characters that would otherwise be treated as pattern metacharacters. You
    /// typically use this method to match on a particular string within a larger pattern.
    /// 
    /// For example, the string "(N/A)" contains the pattern metacharacters (, /, and ). The result of adding backslash escapes to this string is "\\(N\\/A\\)".
    /// 
    /// See Flag Options for the format of the resulting template string.
    /// 
    /// - Parameter string: the template string or substring.
    /// - Returns: the escaped template string.
    ///
    @inlinable public class func escapedTemplate<S>(for string: S) -> String where S: StringProtocol { NSRegularExpression.escapedTemplate(for: ((string as? String) ?? String(string))) }

    /*===========================================================================================================================================================================*/
    /// Returns the number of matches of the regular expression within the specified range of the string.
    /// 
    /// - Parameters:
    ///   - str: the search string.
    ///   - options: The matching options to use. See `RegularExpression.MatchingOptions` for possible values.
    ///   - range: the range of the string to search.
    /// - Returns: the number of matches of the regular expression.
    ///
    @inlinable public func numberOfMatches(in str: String, options: MatchingOptions = [], range: Range<String.Index>) -> Int {
        nsRegex.numberOfMatches(in: str, options: options.convert(), range: NSRange(range, in: str))
    }

    /*===========================================================================================================================================================================*/
    /// Returns the number of matches of the regular expression within the specified range of the string.
    /// 
    /// - Parameters:
    ///   - str: the search string or substring.
    ///   - options: The matching options to use. See `RegularExpression.MatchingOptions` for possible values.
    /// - Returns: the number of matches of the regular expression.
    ///
    @inlinable public func numberOfMatches<S>(in str: S, options: MatchingOptions = []) -> Int where S: StringProtocol {
        let (s, r) = toStringAndRange(str: str)
        return numberOfMatches(in: s, options: options, range: r)
    }

    /*===========================================================================================================================================================================*/
    /// Returns the range of the first match.
    /// 
    /// - Parameters:
    ///   - str: the search string.
    ///   - options: The matching options to use. See `RegularExpression.MatchingOptions` for possible values.
    ///   - range: the range of the string to search.
    /// - Returns: the range of the first match of `nil` if the match was not found.
    ///
    @inlinable public func rangeOfFirstMatch(in str: String, options: MatchingOptions = [], range: Range<String.Index>) -> Range<String.Index>? {
        let r: NSRange = nsRegex.rangeOfFirstMatch(in: str, options: options.convert(), range: NSRange(range, in: str))
        return ((r.location == NSNotFound) ? nil : Range<String.Index>(r, in: str))
    }

    /*===========================================================================================================================================================================*/
    /// Returns the range of the first match.
    /// 
    /// - Parameters:
    ///   - str: the search string or substring.
    ///   - options: The matching options to use. See `RegularExpression.MatchingOptions` for possible values.
    /// - Returns: the range of the first match of `nil` if the match was not found.
    ///
    @inlinable public func rangeOfFirstMatch<S>(in str: S, options: MatchingOptions = []) -> Range<String.Index>? where S: StringProtocol {
        let (s, r) = toStringAndRange(str: str)
        return rangeOfFirstMatch(in: s, options: options, range: r)
    }

    /*===========================================================================================================================================================================*/
    /// Returns the first `RegularExpression.Match` found in the search string.
    /// 
    /// - Parameters:
    ///   - str: the search string.
    ///   - options: The matching options to use. See `RegularExpression.MatchingOptions` for possible values.
    ///   - range: the range of the string to search.
    /// - Returns: the first `RegularExpression.Match` found in the search string or `nil` if the match was not found.
    ///
    @inlinable public func firstMatch(in str: String, options: MatchingOptions = [], range: Range<String.Index>) -> Match? {
        Match(str, match: nsRegex.firstMatch(in: str, options: options.convert(), range: NSRange(range, in: str)))
    }

    /*===========================================================================================================================================================================*/
    /// Returns the first `RegularExpression.Match` found in the search string.
    /// 
    /// - Parameters:
    ///   - str: the search string or substring.
    ///   - options: The matching options to use. See `RegularExpression.MatchingOptions` for possible values.
    /// - Returns: the first `RegularExpression.Match` found in the search string or `nil` if the match was not found.
    ///
    @inlinable public func firstMatch<S>(in str: S, options: MatchingOptions = []) -> Match? where S: StringProtocol {
        let (s, r) = toStringAndRange(str: str)
        return firstMatch(in: s, options: options, range: r)
    }

    /*===========================================================================================================================================================================*/
    /// Returns all of the `RegularExpression.Match`s found in the search string.
    /// 
    /// - Parameters:
    ///   - str: the search string.
    ///   - options: The matching options to use. See `RegularExpression.MatchingOptions` for possible values.
    ///   - range: the range of the string to search.
    /// - Returns: an array of `RegularExpression.Match`s found in the search string or an empty array if the match was not found.
    ///
    @inlinable public func matches(in str: String, options: MatchingOptions = [], range: Range<String.Index>) -> [Match] {
        nsRegex.matches(in: str, options: options.convert(), range: NSRange(range, in: str)).map { Match(str, match: $0)! }
    }

    /*===========================================================================================================================================================================*/
    /// Returns all of the `RegularExpression.Match`s found in the search string.
    /// 
    /// - Parameters:
    ///   - str: the search string or substring.
    ///   - options: The matching options to use. See `RegularExpression.MatchingOptions` for possible values.
    /// - Returns: an array of `RegularExpression.Match`s found in the search string or an empty array if the match was not found.
    ///
    @inlinable public func matches<S>(in str: S, options: MatchingOptions = []) -> [Match] where S: StringProtocol {
        let (s, r) = toStringAndRange(str: str)
        return matches(in: s, options: options, range: r)
    }

    /*===========================================================================================================================================================================*/
    /// Enumerates the string allowing the Block to handle each regular expression match.
    /// 
    /// <b>NOTE:</b> Having this as a throwing function rather than a rethrowing function is not ideal but given that NSRegularExpression doesn't allow the closure to throw
    /// anything sort of removes that option from us. At least I haven't found an easy way around it. So I decided to have to have this method `throws` and in the future, if we
    /// can fix this issue, make it `rethrows` then.
    /// 
    /// This method is the fundamental matching method for regular expressions and is suitable for overriding by subclasses. There are additional convenience methods for returning
    /// all the matches as an array, the total number of matches, the first match, and the range of the first match.
    /// 
    /// By default, the Block iterator method calls the Block precisely once for each match, with a non-`nil` match and the appropriate flags. The client may then stop the
    /// operation by returning `true` from the block instead of `false`.
    /// 
    /// If the `RegularExpression.MatchingOptions.reportProgress` matching option is specified, the Block will also be called periodically during long-running match operations,
    /// with `nil` result and progress matching flag set in the Block’s flags parameter, at which point the client may again stop the operation by returning `true` instead of
    /// `false`.
    /// 
    /// If the `RegularExpression.MatchingOptions.reportCompletion` matching option is specified, the Block object will be called once after matching is complete, with `nil`
    /// result and the completed matching flag is set in the flags passed to the Block, plus any additional relevant `RegularExpression.MatchingFlags` from among
    /// `RegularExpression.MatchingFlags.hitEnd`, `RegularExpression.MatchingFlags.requiredEnd`, or `RegularExpression.MatchingFlags.internalError`.
    /// 
    /// `RegularExpression.MatchingFlags.progress` and `RegularExpression.MatchingFlags.completed` matching flags have no effect for methods other than this method.
    /// 
    /// The `RegularExpression.MatchingFlags.hitEnd` matching flag is set in the flags passed to the Block if the current match operation reached the end of the search range. The
    /// `RegularExpression.MatchingFlags.requiredEnd` matching flag is set in the flags passed to the Block if the current match depended on the location of the end of the search
    /// range.
    /// 
    /// The `RegularExpression.MatchingFlags` matching flag is set in the flags passed to the block if matching failed due to an internal error (such as an expression requiring
    /// exponential memory allocations) without examining the entire search range.
    /// 
    /// The `RegularExpression.Options.anchored`, `RegularExpression.Options.withTransparentBounds`, and `RegularExpression.Options.withoutAnchoringBounds` regular expression
    /// options, specified in the options property specified when the regular expression instance is created, can apply to any match or replace method.
    /// 
    /// If `RegularExpression.Options.anchored` matching option is specified, matches are limited to those at the start of the search range.
    /// 
    /// If `RegularExpression.Options.withTransparentBounds` matching option is specified, matching may examine parts of the string beyond the bounds of the search range, for
    /// purposes such as word boundary detection, lookahead, etc.
    /// 
    /// If `RegularExpression.Options.withoutAnchoringBounds` matching option is specified, ^ and $ will not automatically match the beginning and end of the search range, but
    /// will still match the beginning and end of the entire string.
    /// 
    /// `RegularExpression.Options.withTransparentBounds` and `RegularExpression.Options.withoutAnchoringBounds` matching options have no effect if the search range covers the
    /// entire string.
    /// 
    /// - Parameters:
    ///   - str: the search string.
    ///   - options: The matching options to report. See `RegularExpression.MatchingOptions` for the supported values.
    ///   - range: the range of the string to search.
    ///   - body: the Block that is called for each match found in the search string. The Block takes two (2) parameters&#58; <dl><dt><b><i>match</i></b></dt><dd>An instance of
    ///           `RegularExpression.Match` or `nil` if the Block is simply being called with the flags `RegularExpression.MatchingFlags.completed`,
    ///           `RegularExpression.MatchingFlags.hitEnd`, or `RegularExpression.MatchingFlags.internalError`</dd> <dt><b><i>flags</i></b></dt><dd>An array of
    ///           `RegularExpression.MatchingFlags`.</dd></dl> The closure returns `true` to stop the enumeration or `false` to continue to the next match.
    ///
    @inlinable public func forEachMatch(in str: String, options: MatchingOptions = [], range: Range<String.Index>, using block: (Match?, MatchingFlags, inout Bool) throws -> Void) rethrows {
        try withoutActuallyEscaping(block) { (_block) -> Void in
            var _error: Error? = nil
            nsRegex.enumerateMatches(in: str, options: options.convert(), range: NSRange(range, in: str)) { (chk, flags, stop) -> Void in
                var _stop = false
                do { try _block(Match(str, match: chk), flags.convert(), &_stop) }
                catch let e { _error = e; _stop = true }
                stop.pointee = ObjCBool(_stop)
            }
            if let e = _error { throw e }
        }
    }

    /*===========================================================================================================================================================================*/
    /// Enumerates the string allowing the Block to handle each regular expression match.
    /// 
    /// <b>NOTE:</b> Having this as a throwing function rather than a rethrowing function is not ideal but given that NSRegularExpression doesn't allow the closure to throw
    /// anything sort of removes that option from us. At least I haven't found an easy way around it. So I decided to have to have this method `throws` and in the future, if we
    /// can fix this issue, make it `rethrows` then.
    /// 
    /// This method is the fundamental matching method for regular expressions and is suitable for overriding by subclasses. There are additional convenience methods for returning
    /// all the matches as an array, the total number of matches, the first match, and the range of the first match.
    /// 
    /// By default, the Block iterator method calls the Block precisely once for each match, with a non-`nil` match and the appropriate flags. The client may then stop the
    /// operation by returning `true` from the block instead of `false`.
    /// 
    /// If the `RegularExpression.MatchingOptions.reportProgress` matching option is specified, the Block will also be called periodically during long-running match operations,
    /// with `nil` result and progress matching flag set in the Block’s flags parameter, at which point the client may again stop the operation by returning `true` instead of
    /// `false`.
    /// 
    /// If the `RegularExpression.MatchingOptions.reportCompletion` matching option is specified, the Block object will be called once after matching is complete, with `nil`
    /// result and the completed matching flag is set in the flags passed to the Block, plus any additional relevant `RegularExpression.MatchingFlags` from among
    /// `RegularExpression.MatchingFlags.hitEnd`, `RegularExpression.MatchingFlags.requiredEnd`, or `RegularExpression.MatchingFlags.internalError`.
    /// 
    /// `RegularExpression.MatchingFlags.progress` and `RegularExpression.MatchingFlags.completed` matching flags have no effect for methods other than this method.
    /// 
    /// The `RegularExpression.MatchingFlags.hitEnd` matching flag is set in the flags passed to the Block if the current match operation reached the end of the search range. The
    /// `RegularExpression.MatchingFlags.requiredEnd` matching flag is set in the flags passed to the Block if the current match depended on the location of the end of the search
    /// range.
    /// 
    /// The `RegularExpression.MatchingFlags` matching flag is set in the flags passed to the block if matching failed due to an internal error (such as an expression requiring
    /// exponential memory allocations) without examining the entire search range.
    /// 
    /// The `RegularExpression.Options.anchored`, `RegularExpression.Options.withTransparentBounds`, and `RegularExpression.Options.withoutAnchoringBounds` regular expression
    /// options, specified in the options property specified when the regular expression instance is created, can apply to any match or replace method.
    /// 
    /// If `RegularExpression.Options.anchored` matching option is specified, matches are limited to those at the start of the search range.
    /// 
    /// If `RegularExpression.Options.withTransparentBounds` matching option is specified, matching may examine parts of the string beyond the bounds of the search range, for
    /// purposes such as word boundary detection, lookahead, etc.
    /// 
    /// If `RegularExpression.Options.withoutAnchoringBounds` matching option is specified, ^ and $ will not automatically match the beginning and end of the search range, but
    /// will still match the beginning and end of the entire string.
    /// 
    /// `RegularExpression.Options.withTransparentBounds` and `RegularExpression.Options.withoutAnchoringBounds` matching options have no effect if the search range covers the
    /// entire string.
    /// 
    /// - Parameters:
    ///   - str: the search string or substring.
    ///   - options: The matching options to report. See `RegularExpression.MatchingOptions` for the supported values.
    ///   - body: the Block that is called for each match found in the search string. The Block takes two (2) parameters&#58; <dl><dt><b><i>match</i></b></dt><dd>An instance of
    ///           `RegularExpression.Match` or `nil` if the Block is simply being called with the flags `RegularExpression.MatchingFlags.completed`,
    ///           `RegularExpression.MatchingFlags.hitEnd`, or `RegularExpression.MatchingFlags.internalError`</dd> <dt><b><i>flags</i></b></dt><dd>An array of
    ///           `RegularExpression.MatchingFlags`.</dd></dl> The closure returns `true` to stop the enumeration or `false` to continue to the next match.
    ///
    @inlinable public func forEachMatch<S>(in str: S, options: MatchingOptions = [], using block: (Match?, MatchingFlags, inout Bool) throws -> Void) rethrows where S: StringProtocol {
        let (_str, _rng) = toStringAndRange(str: str)
        try forEachMatch(in: _str, options: options, range: _rng, using: block)
    }

    /*===========================================================================================================================================================================*/
    /// Enumerates the string allowing the Block to handle each regular expression match.
    /// 
    /// This method is the fundamental matching method for regular expressions and is suitable for overriding by subclasses. There are additional convenience methods for returning
    /// all the matches as an array, the total number of matches, the first match, and the range of the first match.
    /// 
    /// By default, the Block iterator method calls the Block precisely once for each match, with an array of the `RegularExpression.Group`s representing each capture group. The
    /// client may then stop the operation by returning `true` from the block instead of `false`.
    /// 
    /// - Parameters:
    ///   - str: the search string.
    ///   - options: The matching options to report. See `RegularExpression.MatchingOptions` for the supported values.
    ///   - range: the range of the string to search.
    ///   - body: the closure that is called for each match found in the search string. The closure takes one parameter which is an array of `RegularExpression.Group` objects
    ///           representing each capture group and returns `true` to stop the enumeration or `false` to continue to the next match.
    ///
    @inlinable public func forEachMatchGroup(in str: String, options: MatchingOptions = [], range: Range<String.Index>, using block: ([Group], inout Bool) throws -> Void) rethrows {
        try forEachMatch(in: str, options: options, range: range) { match, _, stop in if let m = match { try block(m.groups, &stop) } }
    }

    /*===========================================================================================================================================================================*/
    /// Enumerates the string allowing the Block to handle each regular expression match.
    /// 
    /// This method is the fundamental matching method for regular expressions and is suitable for overriding by subclasses. There are additional convenience methods for returning
    /// all the matches as an array, the total number of matches, the first match, and the range of the first match.
    /// 
    /// By default, the Block iterator method calls the Block precisely once for each match, with an array of the `RegularExpression.Group`s representing each capture group. The
    /// client may then stop the operation by returning `true` from the block instead of `false`.
    /// 
    /// - Parameters:
    ///   - str: the search string or substring.
    ///   - options: The matching options to report. See `RegularExpression.MatchingOptions` for the supported values.
    ///   - body: the closure that is called for each match found in the search string. The closure takes one parameter which is an array of `RegularExpression.Group` objects
    ///           representing each capture group and returns `true` to stop the enumeration or `false` to continue to the next match.
    ///
    @inlinable public func forEachMatchGroup<S>(in str: S, options: MatchingOptions = [], using block: ([Group], inout Bool) throws -> Void) rethrows where S: StringProtocol {
        let (_str, _rng) = toStringAndRange(str: str)
        try forEachMatchGroup(in: _str, options: options, range: _rng, using: block)
    }

    /*===========================================================================================================================================================================*/
    /// Enumerates the string allowing the Block to handle each regular expression match.
    /// 
    /// - Parameters:
    ///   - str: the search string.
    ///   - options: The matching options to report. See `RegularExpression.MatchingOptions` for the supported values.
    ///   - range: the range of the string to search.
    ///   - body: the closure that is called for each match found in the search string. The closure takes one parameter which is an array of Strings representing each capture
    ///           group and returns `true` to stop the enumeration or `false` to continue to the next match. Any of the strings in the array may be `nil` if that capture group did
    ///           not participate in the match.
    ///
    @inlinable public func forEachMatchString(in str: String, options: MatchingOptions = [], range: Range<String.Index>, using block: ([String?], inout Bool) throws -> Void) rethrows {
        try forEachMatchGroup(in: str, options: options, range: range) { groups, stop in try block(groups.map { $0.subString }, &stop) }
    }

    /*===========================================================================================================================================================================*/
    /// Enumerates the string allowing the Block to handle each regular expression match.
    /// 
    /// - Parameters:
    ///   - str: the search string or substring.
    ///   - options: The matching options to report. See `RegularExpression.MatchingOptions` for the supported values.
    ///   - body: the closure that is called for each match found in the search string. The closure takes one parameter which is an array of Strings representing each capture
    ///           group and returns `true` to stop the enumeration or `false` to continue to the next match. Any of the strings in the array may be `nil` if that capture group did
    ///           not participate in the match.
    ///
    @inlinable public func forEachMatchString<S>(in str: S, options: MatchingOptions = [], using block: ([String?], inout Bool) throws -> Void) rethrows where S: StringProtocol {
        let (_str, _rng) = toStringAndRange(str: str)
        try forEachMatchString(in: _str, options: options, range: _rng, using: block)
    }

    /*===========================================================================================================================================================================*/
    /// RegularExpression also provides a find-and-replace method for strings. The replacement is treated as a template, with $0 being replaced by the contents of the matched
    /// range, $1 by the contents of the first capture group, and so on. Additional digits beyond the maximum required to represent the number of capture groups will be treated as
    /// ordinary characters, as will a $ not followed by digits. Backslash will escape both $ and itself.
    /// 
    /// - Parameters:
    ///   - string: the string.
    ///   - options: the match options.
    ///   - range: the range of the string to search in. If `nil` then the entire string will be searched.
    ///   - templ: the replacement template.
    /// - Returns: a tuple with the modified string and the number of replacements made.
    ///
    @inlinable public func stringByReplacingMatches(in str: String, options: MatchingOptions = [], range: Range<String.Index>, withTemplate templ: String) -> (String, Int) {
        let mStr = NSMutableString(string: str)
        let cc   = nsRegex.replaceMatches(in: mStr, options: options.convert(), range: NSRange(range, in: str), withTemplate: templ)
        return (String(mStr), cc)
    }

    /*===========================================================================================================================================================================*/
    /// RegularExpression also provides a find-and-replace method for strings. The replacement is treated as a template, with $0 being replaced by the contents of the matched
    /// range, $1 by the contents of the first capture group, and so on. Additional digits beyond the maximum required to represent the number of capture groups will be treated as
    /// ordinary characters, as will a $ not followed by digits. Backslash will escape both $ and itself.
    /// 
    /// - Parameters:
    ///   - string: the string or substring.
    ///   - options: the match options.
    ///   - templ: the replacement template.
    /// - Returns: a tuple with the modified string and the number of replacements made.
    ///
    @inlinable public func stringByReplacingMatches<S>(in str: S, options: MatchingOptions = [], withTemplate templ: String) -> (String, Int) where S: StringProtocol {
        let (_str, _rng) = toStringAndRange(str: str)
        return stringByReplacingMatches(in: _str, options: options, range: _rng, withTemplate: templ)
    }

    /*===========================================================================================================================================================================*/
    /// This method will perform a find-and-replace on the provided string by calling the closure for each match found in the source string and replacing it with the string
    /// returned by the closure.
    /// 
    /// - Parameters:
    ///   - str: the source string.
    ///   - options: the match options.
    ///   - range: the range of the string to search in. If `nil` then the entire string will be searched.
    ///   - body: the closure that will return the replacement string. It is called once for each match found in the source string.
    /// - Returns: a tuple with the modified string and the number of replacements made.
    /// - Throws: if the closure throws an error.
    ///
    @inlinable public func stringByReplacingMatches(in str: String, options: MatchingOptions = [], range: Range<String.Index>, using block: (Match) throws -> String) rethrows -> (String, Int) {
        var out: String       = ""
        var cc:  Int          = 0
        var idx: String.Index = str.startIndex

        try forEachMatch(in: str, options: options, range: range) { m, _, stop in
            if let m = m {
                out.append(contentsOf: str[idx ..< m.range.lowerBound])
                out.append(contentsOf: try block(m))
                idx = m.range.upperBound
                cc += 1
            }
        }

        if idx < str.endIndex { out.append(contentsOf: str[idx ..< str.endIndex]) }
        return (out, cc)
    }

    /*===========================================================================================================================================================================*/
    /// This method will perform a find-and-replace on the provided string by calling the closure for each match found in the source string and replacing it with the string
    /// returned by the closure.
    /// 
    /// - Parameters:
    ///   - str: the source string or substring.
    ///   - options: the match options.
    ///   - body: the closure that will return the replacement string. It is called once for each match found in the source string.
    /// - Returns: a tuple with the modified string and the number of replacements made.
    /// - Throws: if the closure throws an error.
    ///
    @inlinable public func stringByReplacingMatches<S>(in str: S, options: MatchingOptions = [], using block: (Match) throws -> String) rethrows -> (String, Int) where S: StringProtocol {
        let (_str, _rng) = toStringAndRange(str: str)
        return try stringByReplacingMatches(in: _str, options: options, range: _rng, using: block)
    }
}
