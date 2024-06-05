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
var parent = Array(0...n)
var rank = [Int](repeating: 0, count: n + 1)

func find(_ x: Int) -> Int {
    if parent[x] != x {
        parent[x] = find(parent[x])
    }
    return parent[x]
}

func union(_ x: Int, _ y: Int) {
    let rootX = find(x)
    let rootY = find(y)
    
    if rootX != rootY {
        if rank[rootX] > rank[rootY] {
            parent[rootY] = rootX
        } else if rank[rootX] < rank[rootY] {
            parent[rootX] = rootY
        } else {
            parent[rootY] = rootX
            rank[rootX] += 1
        }
    }
}

for _ in 0..<m {
    let unionFind = fIO.readInt()
    let a = fIO.readInt()
    let b = fIO.readInt()
    
    if unionFind == 0 {
        union(a, b)
    } else {
        let rootA = find(a)
        let rootB = find(b)
        print(rootA == rootB ? "YES" : "NO")
    }
}
