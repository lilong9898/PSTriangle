//
//  PascalTriangle.swift
//  NewBull
//
//  Created by lilong01 on 2020/8/24.
//  Copyright © 2020 yuanfudao. All rights reserved.
//

/** 给指定的行生成该行的数字 */
private func generateNumbersForLine(lineToNumbers: [Int: [Int]], line: Int) -> [Int] {
    var numbers = [Int]()
    guard let previousLineNumbers = lineToNumbers[line - 1] else {
        print("error : line \(line - 1) has no numbers")
        return numbers
    }
    for index in 0 ... previousLineNumbers.count {
        if index == 0 || index == previousLineNumbers.count {
            numbers.append(1)
        } else {
            numbers.append(previousLineNumbers[index - 1] + previousLineNumbers[index])
        }
    }
    return numbers
}

/** 给所有行生成数字 */
private func generateNumbersForAllLines(maxLines: Int) -> [Int: [Int]] {
    var lineToNumbers = [Int: [Int]]()
    lineToNumbers[1] = [1, 2, 1]

    for line in 2 ... maxLines {
        let numbers = generateNumbersForLine(lineToNumbers: lineToNumbers, line: line)
        lineToNumbers[line] = numbers
    }

    return lineToNumbers
}

/** 将数字按照固定的宽度转换成字符串，数字居右 */
private func convertNumberToStr(tabWidth: Int, number: Int) -> String {
    var elementStr = String(number)
    if tabWidth > elementStr.count {
        for _ in 0 ..< tabWidth - elementStr.count {
            elementStr = " " + elementStr
        }
    }
    return elementStr
}

/** 给所有行生成字符串 */
private func generateStrsForAllLines(tabWidth: Int, lineToNumbers: [Int: [Int]]) -> [Int: [String]] {
    var lineToStrs = [Int: [String]]()
    for (line, numbers) in lineToNumbers {
        var lineStrs = [String]()
        for number in numbers {
            lineStrs.append(convertNumberToStr(tabWidth: tabWidth, number: number))
        }
        lineToStrs[line] = lineStrs
    }
    return lineToStrs
}

/** 给指定的行生成开头的空格组成的字符串 */
private func generateLeadingSpacesForLine(line: Int, maxDisplayedLine: Int, tabWidth: Int) -> String {
    let leadingSpaceCount = (maxDisplayedLine - line) * tabWidth / 2
    var leadingSpaceStr = ""
    for _ in 0 ..< leadingSpaceCount {
        leadingSpaceStr += " "
    }
    return leadingSpaceStr
}

/** 打印杨辉三角 */
func printPascalTriangle(maxLines: Int, tabWidth: Int, displayedLines: Int...) {
    let lineToNumbers = generateNumbersForAllLines(maxLines: maxLines)
    let lineToStrs = generateStrsForAllLines(tabWidth: tabWidth, lineToNumbers: lineToNumbers)

    guard let maxDisplayedLine = displayedLines.max() else {
        print("error : can not find max element of displayedLines = \(displayedLines)")
        return
    }

    for displayedLine in displayedLines {
        let leadingSpacesStr = generateLeadingSpacesForLine(
            line: displayedLine,
            maxDisplayedLine: maxDisplayedLine,
            tabWidth: tabWidth
        )
        guard let lineStrsWithoutLeadingSpaces = lineToStrs[displayedLine] else {
            print("error : line \(displayedLine) has no strings")
            return
        }
        let contentStr = lineStrsWithoutLeadingSpaces.joined(separator: "")
        print("\(leadingSpacesStr)\(contentStr)")
    }
}
