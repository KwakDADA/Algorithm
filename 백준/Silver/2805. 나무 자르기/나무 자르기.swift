import Foundation

final class FileIO {
    private let buffer:[UInt8]
    private var index: Int = 0

    init(fileHandle: FileHandle = FileHandle.standardInput) {
        
        buffer = Array(try! fileHandle.readToEnd()!)+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
    }

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }

        return buffer[index]
    }

    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true

        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }

        return sum * (isPositive ? 1:-1)
    }

    @inline(__always) func readString() -> String {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시

        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return String(bytes: Array(buffer[beginIndex..<(index-1)]), encoding: .ascii)!
    }

    @inline(__always) func readByteSequenceWithoutSpaceAndLineFeed() -> [UInt8] {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시

        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return Array(buffer[beginIndex..<(index-1)])
    }
}

let fIO = FileIO()
let n = fIO.readInt()
let m = fIO.readInt()
var trees = [Int](repeating: 0, count: n)
var longest = Int.min
var prevLength = -1
var close = Int.max

for i in 0..<n {
    trees[i] = fIO.readInt()
    longest = max(trees[i], longest)
}
var cut = longest / 2
var d = cut

outer: while true {
    d = d / 2 == 0 ? 1 : d / 2
    let treesCut: [Int] = trees.map {
        let l = $0 - cut
        return l >= 0 ? l : 0
    }
    
    let totalLength = treesCut.reduce(0, +)
    
    switch totalLength {
    case 0..<m:
        cut -= d
    case m:
        break outer
    default:
        if close == totalLength - m {
            break outer
        }
        close = totalLength - m
        cut += d
    }
    prevLength = totalLength
}

print(cut)
