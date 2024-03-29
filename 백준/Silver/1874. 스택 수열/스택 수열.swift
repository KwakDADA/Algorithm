func sequence(n: Int) -> String {
    var target = Int(readLine()!)!
    var stack = [Int]()
    var result = ""
    
    for i in 1...n {
        if stack.isEmpty || target > stack.last! {
            stack.append(i)
            result.append("+\n")
            while !stack.isEmpty && target == stack.last! {
                stack.removeLast()
                result.append("-\n")
                target = Int(readLine() ?? "0")!
            }
        }
    }
    return stack.isEmpty ? result : "NO"
}

print(sequence(n: Int(readLine()!)!))