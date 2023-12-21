// import Algorithms
import Foundation

struct Day00: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [String] {
    data.split(separator: "\n").map {
      String($0)
    }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
//    let regex = try! NSRegularExpression(pattern: "\\d|one|two|three|four|five|six|seven|eight|nine")
//    let regex = try! NSRegularExpression(pattern: "(?=three)|(?=seven)|(?=eight)|(?=nine)")
    let regex = try! NSRegularExpression(pattern: "(?=(three|eight))")


    // Calculate the sum of the first set of input data
    let lines = entities.map { stringToCheck in
      log("String to check: \"\(stringToCheck)\"")
      let matches = regex.matches(in: stringToCheck, range: NSRange(stringToCheck.startIndex..., in: stringToCheck))
      let numbers = matches.map { textCheckingResult in
//        let matchedString = String(Range(textCheckingResult.range, in: stringToCheck))

        debug("found \(textCheckingResult)")
        let matchRange = textCheckingResult.range
        debug("  Range: \(matchRange)")
//        let substring = stringToCheck.substring(with: textCheckingResult.range)
        let substring = stringToCheck.substring(with: Range<String.Index>(textCheckingResult.range, in: stringToCheck)!)
//        print("Length: \(textCheckingResult.range.length)")
        debug("  Number: \(substring)")
        if let digit = Int(substring) {
          return digit
        } else {
          switch substring {
          case "one":
            return 1
          case "two":
            return 2
          case "three":
            return 3
          case "four":
            return 4
          case "five":
            return 5
          case "six":
            return 6
          case "seven":
            return 7
          case "eight":
            return 8
          case "nine":
            return 9
          default:
            return 999
          }
        }
      }
      debug("  Numbers: \(numbers)")
      let first = numbers.first!
//      print("First: \(first)")
      let last = numbers.last!
//      print("Last: \(last)")
      let calibrationValue = "\(first)\(last)"
      debug("  Value: \(calibrationValue)")

//      print(matches)
      print("")
      return Int(calibrationValue)!
    }
    print("Lines: \(lines)")
    let sum = lines.reduce(0, +)
    print("Sum: \(sum)")
//      $0.isNumber }.compactMap { Int(String($0)) }
//    entities.map {
//      print($0)
//    }
    return []
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part1new() -> Any {


    // Calculate the sum of the first set of input data
    let _ = entities.map { stringToCheck in
      print("String: \(stringToCheck)")
      if let first = stringToCheck.firstMatch(of: #/(?=eight|three)/#) {
        print("Match: \(first)")
        print("First: \(first.0)")
//        print("Second: \(first)")
        print("")
      }

      return 88
    }

    return []
  }
}
