import Foundation

public enum ASCIIColor: String {
    case black = "\u{001B}[0;30m"
    case red = "\u{001B}[0;31m"
    case green = "\u{001B}[0;32m"
    case yellow = "\u{001B}[0;33m"
    case blue = "\u{001B}[0;34m"
    case magenta = "\u{001B}[0;35m"
    case cyan = "\u{001B}[0;36m"
    case white = "\u{001B}[0;37m"
    case dim = "\u{001B}[0;2m"
    case `default` = "\u{001B}[0;0m"
}

extension DefaultStringInterpolation {
    mutating func appendInterpolation<T: CustomStringConvertible>(_ value: T, color: ASCIIColor) {
        appendInterpolation("\(color.rawValue)\(value)\(ASCIIColor.default.rawValue)")
    }
}

func logMessage(_ message: String, color: ASCIIColor, newline: Bool = true) {
    let terminator: String
    if newline {
        terminator = "\n"
    } else {
        terminator = ""
    }
    print("\(message, color: color)", terminator: terminator)
}

public func log(_ message: String, color: ASCIIColor = .blue, newline: Bool = true) {
    logMessage(message, color: color, newline: newline)
}

public func debug(_ message: String, newline: Bool = true) {
    logMessage(message, color: .dim, newline: newline)
}

public func warning(_ message: String, newline: Bool = true) {
    logMessage(message, color: .yellow, newline: newline)
}
