let nm = readLine()!.split(separator: " ").map{Int(String($0))!}
let num = readLine()!.split(separator: " ").map{Int(String($0))!}.sorted()
let n = nm[0], m = nm[1]

var str = ""
func backTracking(_ k: Int, _ line: String) {
    if k == m {
        str += line + "\n"
        return
    }
    
    for i in 0..<n {
        backTracking(k + 1, line + "\(num[i]) ")
    }
}

backTracking(0, "")
print(str)