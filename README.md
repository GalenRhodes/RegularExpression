# RegularExpression

RegularExpression is a replacement for
[NSRegularExpression](https://developer.apple.com/documentation/foundation/nsregularexpression) that is much more Swift friendly.

## A Note about the methods that take closures:
I know that having these methods as `throws` rather than a `rethrows` is not ideal but given that NSRegularExpression doesn't allow
it's closure to be `throws` sort of leaves us no choice. At least I haven't found an easy way around it. So I decided to have 
these methods as `throws` and in the future, if we can fix this issue, make them `rethrows` then.

# BLOG Post
I, Introvert - [A Better RegularExpression](https://blog.projectgalen.com/2021/02/12/a-better-regularexpression/)

# API Documentation
Documentation of the API can be found here: [RegularExpression API](http://galenrhodes.com/RegularExpression/)
